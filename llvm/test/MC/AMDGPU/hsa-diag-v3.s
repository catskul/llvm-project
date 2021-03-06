// RUN: not llvm-mc -triple amdgcn-amd-amdhsa -mcpu=gfx803 -mattr=+xnack -show-encoding %s 2>&1 >/dev/null | FileCheck %s --check-prefixes=GFX8,NONGFX90A,NONGFX10,AMDHSA,ALL
// RUN: not llvm-mc -triple amdgcn-amd-amdhsa -mcpu=gfx1010 -mattr=+xnack -show-encoding %s 2>&1 >/dev/null | FileCheck %s --check-prefixes=NONGFX8,NONGFX90A,GFX10,AMDHSA,ALL
// RUN: not llvm-mc -triple amdgcn-amd- -mcpu=gfx803 -mattr=+xnack -show-encoding %s 2>&1 >/dev/null | FileCheck %s --check-prefixes=NONAMDHSA,ALL

.text

// ALL-LABEL: warning: test_target
// GFX8-NOT: error:
// GFX10: error: target must match options
// NONAMDHSA: error: unknown directive
.warning "test_target"
.amdgcn_target "amdgcn-amd-amdhsa--gfx803+xnack"

// ALL-LABEL: warning: test_amdhsa_kernel_no_name
// ALL: error: unknown directive
.warning "test_amdhsa_kernel_no_name"
.amdhsa_kernel
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_kernel_empty
// AMDHSA-NOT: error: unknown directive
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_kernel_empty"
.amdhsa_kernel test_amdhsa_kernel_empty
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_kernel_unknown_directive
// AMDHSA: error: expected .amdhsa_ directive or .end_amdhsa_kernel
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_kernel_unknown_directive"
.amdhsa_kernel test_amdhsa_kernel_unknown_directive
  1
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_group_segment_fixed_size_invalid_size
// AMDHSA: error: value out of range
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_group_segment_fixed_size_invalid_size"
.amdhsa_kernel test_amdhsa_group_segment_fixed_size_invalid_size
  .amdhsa_group_segment_fixed_size -1
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_group_segment_fixed_size_invalid_expression
// AMDHSA: error: value out of range
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_group_segment_fixed_size_invalid_expression"
.amdhsa_kernel test_amdhsa_group_segment_fixed_size_invalid_expression
  .amdhsa_group_segment_fixed_size 10000000000 + 1
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_group_segment_fixed_size_repeated
// AMDHSA: error: .amdhsa_ directives cannot be repeated
// NONAMDHSA-: error: unknown directive
.warning "test_amdhsa_group_segment_fixed_size_repeated"
.amdhsa_kernel test_amdhsa_group_segment_fixed_size_repeated
  .amdhsa_group_segment_fixed_size 1
  .amdhsa_group_segment_fixed_size 1
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_next_free_vgpr_missing
// AMDHSA: error: .amdhsa_next_free_vgpr directive is required
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_next_free_vgpr_missing"
.amdhsa_kernel test_amdhsa_next_free_vgpr_missing
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_next_free_sgpr_missing
// AMDHSA: error: .amdhsa_next_free_sgpr directive is required
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_next_free_sgpr_missing"
.amdhsa_kernel test_amdhsa_next_free_sgpr_missing
  .amdhsa_next_free_vgpr 0
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_wavefront_size32
// NONGFX10: error: directive requires gfx10+
// GFX10: error: .amdhsa_next_free_vgpr directive is required
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_wavefront_size32"
.amdhsa_kernel test_amdhsa_wavefront_size32
  .amdhsa_wavefront_size32 1
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_wavefront_size32_invalid
// NONGFX10: error: directive requires gfx10+
// GFX10: error: value out of range
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_wavefront_size32_invalid"
.amdhsa_kernel test_amdhsa_wavefront_size32_invalid
  .amdhsa_wavefront_size32 5
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_workgroup_processor_mode
// NONGFX10: error: directive requires gfx10+
// GFX10: error: .amdhsa_next_free_vgpr directive is required
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_workgroup_processor_mode"
.amdhsa_kernel test_amdhsa_workgroup_processor_mode
  .amdhsa_workgroup_processor_mode 1
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_workgroup_processor_mode_invalid
// NONGFX10: error: directive requires gfx10+
// GFX10: error: value out of range
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_workgroup_processor_mode_invalid"
.amdhsa_kernel test_amdhsa_workgroup_processor_mode_invalid
  .amdhsa_workgroup_processor_mode 5
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_memory_ordered
// NONGFX10: error: directive requires gfx10+
// GFX10: error: .amdhsa_next_free_vgpr directive is required
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_memory_ordered"
.amdhsa_kernel test_amdhsa_memory_ordered
  .amdhsa_memory_ordered 1
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_memory_ordered_invalid
// NONGFX10: error: directive requires gfx10+
// GFX10: error: value out of range
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_memory_ordered_invalid"
.amdhsa_kernel test_amdhsa_memory_ordered_invalid
  .amdhsa_memory_ordered 5
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_forward_progress
// NONGFX10: error: directive requires gfx10+
// GFX10: error: .amdhsa_next_free_vgpr directive is required
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_forward_progress"
.amdhsa_kernel test_amdhsa_forward_progress
  .amdhsa_forward_progress 1
.end_amdhsa_kernel

// ALL-LABEL: warning: test_amdhsa_forward_progress_invalid
// NONGFX10: error: directive requires gfx10+
// GFX10: error: value out of range
// NONAMDHSA: error: unknown directive
.warning "test_amdhsa_forward_progress_invalid"
.amdhsa_kernel test_amdhsa_forward_progress_invalid
  .amdhsa_forward_progress 5
.end_amdhsa_kernel

// ALL-LABEL: warning: test_next_free_vgpr_invalid
// AMDHSA: error: .amdgcn.next_free_{v,s}gpr symbols must be absolute expressions
// NONAMDHSA-NOT: error:
.warning "test_next_free_vgpr_invalid"
.set .amdgcn.next_free_vgpr, "foo"
v_mov_b32_e32 v0, s0

// ALL-LABEL: warning: test_end
.warning "test_end"
