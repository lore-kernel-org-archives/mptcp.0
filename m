Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625A143C6F
	for <mptcp@lists.linux.dev>; Mon, 26 Aug 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668818; cv=none; b=dGlSXXAiW2WyREaMhRqK5QmGS5FIZ6kuRz0h+9HLLQj41CC644vDtWkq8llsE13k4j+jylwDH5Dp52J0UdCo/nQpxB6PgEgqNXglcrbD7FT9mmF6NdZgxjt/1qYTdFhvbO4HucyCwlzlrBJyivnMVzfDIR9bsJ3lS2A+d7M2Oq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668818; c=relaxed/simple;
	bh=HpdWtXLWHiHdEQejKBiXcBj+rg4ol5Oy1HfO6Nx/PN4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FimJmfF1BP1DmChHVU0n/5FJ0Xc1/svyd+mBhchNbQ9C6lgyXg2VQofAEEIUZ0LKwthw75NMi9OT723VP5zdzR1Zq+fhroAw33di0Jn2ezJE5QESYo8g0EAXP14gTppQMr4gZC+DBeIghCJoyM5YeL16J2i/jgsS9HwlY7i41ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv5r5ljN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv5r5ljN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A23C51401;
	Mon, 26 Aug 2024 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724668818;
	bh=HpdWtXLWHiHdEQejKBiXcBj+rg4ol5Oy1HfO6Nx/PN4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=sv5r5ljN8ULrPwBO1qwAQet+XW6t7NH+8jUNty6AAvPNtDioKwZo2MrDJV2WEIAgk
	 VVuha91Tz4X4zbC03msFgtp2yjoDYjqU6vXorDhpnGglOiE5pX0GmLYrtIrbMG7skb
	 aoYqx0rVzDqpavNm4HLhhwCnhhOGv6xwLcycsNtFTgnziS7ulOPEeWtu8r0cZ56H0b
	 QLj5j44dKoKkwXyw6/3rKNvk5LuVa5fdALjZ9ioX8/tH34u3A6JvOGnQ+KVPw/YNyd
	 JvaZ1dpKVR9NbPYw3i0XlI0HuxcktqErEaAOtQEHgp7i5hd4ptJIf/vW91+2Djo5Pw
	 smLJHo+pzv/Xg==
Message-ID: <9cc735a488122ad01edeb8aadac805205c98a801.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/2] selftests/bpf: Add getsockopt to inspect
 mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Martin KaFai Lau
	 <martin.lau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
Date: Mon, 26 Aug 2024 18:40:12 +0800
In-Reply-To: <4787c89e-e273-41da-b7a4-d3d58d755b76@kernel.org>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
	 <3788544d841aa372a810f2d3dce905612063e872.1724142917.git.tanggeliang@kylinos.cn>
	 <407f6a6a-344e-4f12-9293-e43b9a97f8d4@kernel.org>
	 <23cffc2904df37874f35f106975fccc962d6cb8e.camel@kernel.org>
	 <689e3694-d8f9-4511-8363-6f83a3bb1a1d@kernel.org>
	 <afaa9ac33002da2452d3df014cd61a89fbd4978c.camel@kernel.org>
	 <547fdd31-a052-4274-a59e-d7177887dbbe@kernel.org>
	 <010b2338434b7df67ac418ad7063543e91c946b9.camel@kernel.org>
	 <4787c89e-e273-41da-b7a4-d3d58d755b76@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-08-26 at 11:49 +0200, Matthieu Baerts wrote:
> Hi Geliang, Martin,
> 
> On 26/08/2024 11:24, Geliang Tang wrote:
> > Hi Matt, Martin,
> > 
> > On Mon, 2024-08-26 at 10:44 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > On 26/08/2024 04:57, Geliang Tang wrote:
> > > > On Wed, 2024-08-21 at 11:37 +0200, Matthieu Baerts wrote:
> > > > > On 21/08/2024 10:00, Geliang Tang wrote:
> > > > > > On Tue, 2024-08-20 at 11:48 +0200, Matthieu Baerts wrote:
> > > > > > > On 20/08/2024 10:44, Geliang Tang wrote:
> > > 
> > > (...)
> > > 
> > > > > > > > +	mptcp_for_each_subflow(msk, subflow) {
> > > > > > > 
> > > > > > > (might be better to use this helper in our WIP MPTCP BPF
> > > > > > > packets
> > > > > > > scheduler examples, instead of converting them to a fixed
> > > > > > > array)
> > > > > > 
> > > > > > Yes, but there are still some access permission issues that
> > > > > > need to
> > > > > > be
> > > > > > resolved.
> > > > > 
> > > > > OK, because structures cannot be modified I suppose.
> > > > 
> > > > No, it seems the subflow cast by bpf_core_cast() can't be
> > > > passed to
> > > > a
> > > > kernel function, regardless of whether this function modifies
> > > > the
> > > > subflow or not. An "arg#0 is untrusted_ptr_ expected ptr_"
> > > > error
> > > > occurs.
> > > > 
> > > > For example, mptcp_subflow_active() is a kernel function, and
> > > > pass
> > > > the
> > > > subflow to it in progs/mptcp_bpf_first.c like this:
> > > > 
> > > > '''
> > > > ... ...
> > > > extern bool mptcp_subflow_active(struct mptcp_subflow_context
> > > > *subflow)
> > > > __ksym;
> > > > 
> > > > ... ...
> > > > SEC("struct_ops")
> > > > int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
> > > >              struct mptcp_sched_data *data)
> > > > {
> > > >         struct mptcp_subflow_context *subflow, *tmp;
> > > > 
> > > >         mptcp_for_each_subflow(msk, tmp) {
> > > >                 subflow = bpf_core_cast(tmp, struct
> > > > mptcp_subflow_context);
> > > 
> > > (Why do you need to cast "tmp" (struct mptcp_subflow_context *)
> > > in
> > > the
> > > same type of pointer? I don't think it changes anything for the
> > > error
> > > you got (see below), but it looks strange.)
> > 
> > We must do the cast, otherwise, an "access beyond struct list_head"
> > occurs:
> > 
> > ; token = subflow->token; @ mptcp_subflow.c:92
> > 13: (61) r4 = *(u32 *)(r1 +524)
> > access beyond struct list_head at off 524 size 4
> 
> OK!
> 
> > 
> > See Martin's comment in [1].
> > 
> > [1]
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240805-upstream-bpf-next-20240506-mptcp-subflow-test-v4-2-2b4ca6994993@kernel.org/
> > 
> > > 
> > > >                 if (!mptcp_subflow_active(subflow))
> > > >                         continue;
> > > >         }
> > > >         return 0;
> > > > }
> > > > 
> > > > '''
> > > > 
> > > > An "arg#0 is untrusted_ptr_ expected ptr_" error occurs:
> > > > 
> > > > '''
> > > > ; mptcp_for_each_subflow(msk, tmp) { @ mptcp_bpf_first.c:27
> > > > 21: (e5) may_goto pc+1
> > > > 22: R1=2488 R2=2488 R6=trusted_ptr_mptcp_sock(off=2488) R7=0
> > > > R8=trusted_ptr_mptcp_sock(off=2488) R9=0 R10=fp0
> > > > ; mptcp_for_each_subflow(msk, tmp) { @ mptcp_bpf_first.c:27
> > > > 22: (05) goto pc-14
> > > > 9: (79) r6 = *(u64 *)(r6 +0)          ; R6_w=ptr_list_head()
> > > > 10: (1f) r6 -= r7                     ; R6_w=ptr_list_head()
> > > > R7=0
> > > > 11: (bf) r1 = r6                      ; R1_w=ptr_list_head()
> > > > R6_w=ptr_list_head()
> > > > 12: (0f) r1 += r7                     ; R1=ptr_list_head() R7=0
> > > > 13: (1d) if r1 == r8 goto pc+9        ; R1=ptr_list_head()
> > > > R8=trusted_ptr_mptcp_sock(off=2488)
> > > > ; subflow = bpf_core_cast(tmp, struct mptcp_subflow_context); @
> > > > mptcp_bpf_first.c:28
> > > > 14: (bf) r1 = r6                      ; R1_w=ptr_list_head()
> > > > R6=ptr_list_head()
> > > > 15: (18) r2 = 0x6d14                  ; R2_w=27924
> > > > 17: (85) call bpf_rdonly_cast#159867          ;
> > > > R0_w=untrusted_ptr_mptcp_subflow_context()
> > > > ; if (!mptcp_subflow_active(subflow)) @ mptcp_bpf_first.c:29
> > > > 18: (bf) r1 = r0                      ;
> > > > R0_w=untrusted_ptr_mptcp_subflow_context()
> > > > R1_w=untrusted_ptr_mptcp_subflow_context()
> > > > 19: (85) call mptcp_subflow_active#111397
> > > > arg#0 is untrusted_ptr_ expected ptr_ or socket
> > > > processed 23 insns (limit 1000000) max_states_per_insn 0
> > > > total_states 2
> > > > peak_states 2 mark_read 2
> > > > -- END PROG LOAD LOG --
> > > > '''
> > > > 
> > > > How can I fix this? I need your advice.
> > > 
> > > I'm not an expert in this, but I guess it means you cannot use
> > > 'mptcp_subflow_active()', because it can modify the 'subflow'
> > > structure
> > > that you got with bpf_core_cast() for a read-only usage.
> > 
> > A read-only function will get the same error.
> > 
> > I added a read-only function mptcp_subflow_get_scheduled() for
> > testing:
> > 
> > bool mptcp_subflow_get_scheduled(struct mptcp_subflow_context
> > *subflow)
> 
> Do you have the same issue if '*subflow' is marked as 'const'?

Yes, the same error occurs:

'''
libbpf: prog 'bpf_first_get_subflow': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk, @
mptcp_bpf_first.c:22
0: (b7) r7 = 0                        ; R7_w=0
1: (b7) r2 = 2488                     ; R2_w=2488
2: (79) r8 = *(u64 *)(r1 +0)
func 'get_subflow' arg0 has btf_id 27737 type STRUCT 'mptcp_sock'
3: R1=ctx() R8_w=trusted_ptr_mptcp_sock()
3: (bf) r6 = r8                       ; R6_w=trusted_ptr_mptcp_sock()
R8_w=trusted_ptr_mptcp_sock()
4: (0f) r6 += r2                      ; R2_w=2488
R6_w=trusted_ptr_mptcp_sock(off=2488)
5: (b7) r1 = 2488                     ; R1_w=2488
6: (0f) r8 += r1                      ; R1_w=2488
R8_w=trusted_ptr_mptcp_sock(off=2488)
7: (b7) r9 = 0                        ; R9_w=0
8: (05) goto pc+12
; mptcp_for_each_subflow(msk, tmp) { @ mptcp_bpf_first.c:27
21: (e5) may_goto pc+1
22: R1=2488 R2=2488 R6=trusted_ptr_mptcp_sock(off=2488) R7=0
R8=trusted_ptr_mptcp_sock(off=2488) R9=0 R10=fp0
; mptcp_for_each_subflow(msk, tmp) { @ mptcp_bpf_first.c:27
22: (05) goto pc-14
9: (79) r6 = *(u64 *)(r6 +0)          ; R6_w=ptr_list_head()
10: (1f) r6 -= r7                     ; R6_w=ptr_list_head() R7=0
11: (bf) r1 = r6                      ; R1_w=ptr_list_head()
R6_w=ptr_list_head()
12: (0f) r1 += r7                     ; R1=ptr_list_head() R7=0
13: (1d) if r1 == r8 goto pc+9        ; R1=ptr_list_head()
R8=trusted_ptr_mptcp_sock(off=2488)
; subflow = bpf_core_cast(tmp, struct mptcp_subflow_context); @
mptcp_bpf_first.c:28
14: (bf) r1 = r6                      ; R1_w=ptr_list_head()
R6=ptr_list_head()
15: (18) r2 = 0x6c55                  ; R2_w=27733
17: (85) call bpf_rdonly_cast#122463          ;
R0_w=untrusted_ptr_mptcp_subflow_context()
; mptcp_subflow_get_scheduled(subflow); @ mptcp_bpf_first.c:29
18: (bf) r1 = r0                      ;
R0_w=untrusted_ptr_mptcp_subflow_context()
R1_w=untrusted_ptr_mptcp_subflow_context()
19: (85) call mptcp_subflow_get_scheduled#127716
arg#0 is untrusted_ptr_ expected ptr_ or socket
processed 23 insns (limit 1000000) max_states_per_insn 0 total_states 2
peak_states 2 mark_read 2
-- END PROG LOAD LOG --
'''

net/mptcp/sched.c:

'''
bool mptcp_subflow_get_scheduled(const struct mptcp_subflow_context
*subflow)
{
       return subflow->scheduled;
}
'''

progs/mptcp_bpf_first.c:

'''
extern bool mptcp_subflow_get_scheduled(const struct
mptcp_subflow_context *subflow) __ksym;

... ...

SEC("struct_ops")
int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
             struct mptcp_sched_data *data)
{
        struct mptcp_subflow_context *subflow, *tmp;

        mptcp_for_each_subflow(msk, tmp) {
                subflow = bpf_core_cast(tmp, struct
mptcp_subflow_context);
                mptcp_subflow_get_scheduled(subflow);
        }
        return 0;
}
'''

Thanks,
-Geliang

> 
> > {
> >         return subflow->scheduled;
> > }
> > 
> > And invoke it from BPF in mptcp_for_each_subflow() loop:
> > 
> > int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
> >              struct mptcp_sched_data *data)
> > {
> >         struct mptcp_subflow_context *subflow, *tmp;
> > 
> >         mptcp_for_each_subflow(msk, tmp) {
> >                 subflow = bpf_core_cast(tmp, struct
> > mptcp_subflow_context);
> >                 mptcp_subflow_get_scheduled(subflow);
> >         }
> >         return 0;
> > }
> > 
> > The same "arg#0 is untrusted_ptr_ expected ptr_ or socket" occurs.
> > 
> > Hope Martin can give us a solution for this issue.
> > 
> > Thanks,
> > -Geliang
> > 
> > > 
> > > I guess it means we cannot iterate through the list and modify
> > > items
> > > from the list "directly" with BPF. Except if there is something
> > > else
> > > we
> > > can use, and I don't know about (which is very likely), we might
> > > have
> > > to
> > > continue extracting the subflows into an array of a fixed size.
> > > 
> > > Cheers,
> > > Matt
> > 
> 
> Cheers,
> Matt

