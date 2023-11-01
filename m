Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AC134A0
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me+92Qpi"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-32db188e254so4512212f8f.0
        for <mptcp@lists.linux.dev>; Wed, 01 Nov 2023 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698843191; x=1699447991; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMlCau0fI4sdavwZRK5p5wlnTZXaJTlBtG1j/eq9FFo=;
        b=Me+92QpiFxluuUjrAL0WeYkm2Ks/JWt19/KWb/ip3S7gfaQraWGmvdNCOlnGtCQ/1O
         NiMa3dYm1+VJ5rGlXcyORFj0DYTzqSGP/nE+TQjQO3ZpWZuuDbABGQozRRuC+sc5aEU3
         Z4dBwuREVfMvicMMzYg7uppzN9ehsVs3lmZfVJKCHeks+Csf6pmG30kngYnXGuEohrd6
         mJtS0GdVq4QWPUuqiuaKNHRsm6IFIKbfhERAGlLtye3JNj1+pLS1js7EuyEbAC7IA15c
         Xq7H+Z0seyI8m/0dBkhnXEMjqZIZZsJVpaGLdkLtUAn59qUdhymt2VymcNpm0/fA0kwI
         TE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698843191; x=1699447991;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMlCau0fI4sdavwZRK5p5wlnTZXaJTlBtG1j/eq9FFo=;
        b=RMcDu0Vog04vnmEnRDXYZ7rKuS1Qc64gvO4HDgKM2Bcrh9KcrZELmV265u2uh3r/Fg
         DOtqcKooFuScGfQQXX3rMOYLnGgKn+/u6OfPchBRWzxEInb8RDy02Ij7ZYCbwvki0R/0
         E14Dj1N6AqoPWJ33RJNQxVPBxgeMWm+x2t0460NIG/YDjnHrYIqGvWoxc1EW+luy1QkQ
         V0qHZzj0CH5tU3A1PjqFXrbUlTQpLtvVcC15mErKpR/RQtaBuN9mVpI0IpIFcBstHBAu
         t89ZSa3ZVdQcfLjt3ZfxREAc/QWOC73xuw4V2ijmXkPk91ciJzXzfvEDyqCBs+4/LBzX
         c5qw==
X-Gm-Message-State: AOJu0YyNl3s0uczHiloLc1kMzcZjExPUIK8USImchmfvtV8zB/k0HrVI
	ZT/iI6mnnY6NCWrb8/h5xs0=
X-Google-Smtp-Source: AGHT+IEGPHzF7kjH83YhRGhNE5DcZxgC8jkHWx367f8xz0FG2qEBO/EcWkj2OWhERERzKjfCarwi3g==
X-Received: by 2002:adf:e48a:0:b0:32d:95ef:9281 with SMTP id i10-20020adfe48a000000b0032d95ef9281mr13513008wrm.4.1698843190522;
        Wed, 01 Nov 2023 05:53:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id m18-20020adff392000000b0032daf848f68sm4061778wro.59.2023.11.01.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 05:53:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 1 Nov 2023 13:53:07 +0100
To: Matthieu Baerts <matttbe@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Chuyi Zhou <zhouchuyi@bytedance.com>,
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: fix compilation error without CGROUPS
Message-ID: <ZUJKM5mRsg0CQifW@krava>
References: <20231031-bpf-compil-err-css-v1-1-e2244c637835@kernel.org>
 <ZUEzzc/Sod8OR28B@krava>
 <CAADnVQKCNFxcpE9Y250iwd8E4+t_Pror0AuRaoRYepUkXj56UA@mail.gmail.com>
 <ZUH9cveAsjcUgz9e@krava>
 <9aad3bb9-daca-405a-93c3-dccea3c0a07a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9aad3bb9-daca-405a-93c3-dccea3c0a07a@kernel.org>

On Wed, Nov 01, 2023 at 09:25:34AM +0100, Matthieu Baerts wrote:
> Hi Jirka, Alexei,
> 
> On 01/11/2023 08:25, Jiri Olsa wrote:
> > On Tue, Oct 31, 2023 at 08:54:56PM -0700, Alexei Starovoitov wrote:
> >> On Tue, Oct 31, 2023 at 10:05 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>>
> >>> On Tue, Oct 31, 2023 at 04:49:34PM +0100, Matthieu Baerts wrote:
> >>>> Our MPTCP CI complained [1] -- and KBuild too -- that it was no longer
> >>>> possible to build the kernel without CONFIG_CGROUPS:
> >>>>
> >>>>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
> >>>>   kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
> >>>>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >>>>         |              ^~~~~~~~~~~~~~~~~~~
> >>>>   kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is reported only once for each function it appears in
> >>>>   kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
> >>>>     919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
> >>>>         |                                    ^~~~~~~~~~~~~~~~~~~~~~
> >>>>   kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof' to incomplete type 'struct css_task_iter'
> >>>>     927 |         kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
> >>>>         |                                                            ^~~~~~
> >>>>   kernel/bpf/task_iter.c:930:9: error: implicit declaration of function 'css_task_iter_start'; did you mean 'task_seq_start'? [-Werror=implicit-function-declaration]
> >>>>     930 |         css_task_iter_start(css, flags, kit->css_it);
> >>>>         |         ^~~~~~~~~~~~~~~~~~~
> >>>>         |         task_seq_start
> >>>>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_next':
> >>>>   kernel/bpf/task_iter.c:940:16: error: implicit declaration of function 'css_task_iter_next'; did you mean 'class_dev_iter_next'? [-Werror=implicit-function-declaration]
> >>>>     940 |         return css_task_iter_next(kit->css_it);
> >>>>         |                ^~~~~~~~~~~~~~~~~~
> >>>>         |                class_dev_iter_next
> >>>>   kernel/bpf/task_iter.c:940:16: error: returning 'int' from a function with return type 'struct task_struct *' makes pointer from integer without a cast [-Werror=int-conversion]
> >>>>     940 |         return css_task_iter_next(kit->css_it);
> >>>>         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>>>   kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_destroy':
> >>>>   kernel/bpf/task_iter.c:949:9: error: implicit declaration of function 'css_task_iter_end' [-Werror=implicit-function-declaration]
> >>>>     949 |         css_task_iter_end(kit->css_it);
> >>>>         |         ^~~~~~~~~~~~~~~~~
> >>>>
> >>>> This patch simply surrounds with a #ifdef the new code requiring CGroups
> >>>> support. It seems enough for the compiler and this is similar to
> >>>> bpf_iter_css_{new,next,destroy}() functions where no other #ifdef have
> >>>> been added in kernel/bpf/helpers.c and in the selftests.
> >>>>
> >>>> Fixes: 9c66dc94b62a ("bpf: Introduce css_task open-coded iterator kfuncs")
> >>>> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6665206927
> >>>> Reported-by: kernel test robot <lkp@intel.com>
> >>>> Closes: https://lore.kernel.org/oe-kbuild-all/202310260528.aHWgVFqq-lkp@intel.com/
> >>>> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> >>>
> >>> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>
> >>
> >> I believe this patch has the same issue as Arnd's patch:
> >> https://lore.kernel.org/all/CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpoR1RQ@mail.gmail.com/
> 
> @Alexei: Arf, sorry, I didn't find this patch when searching for
> "9c66dc94b62a" on lore. I don't know why I didn't search for the commit
> title as usual...
> 
> >> I'd like to merge the fix asap. Please make it a complete fix.
> > 
> > ugh, it won't fail the build, it just warns.. I think we should
> > fail the build in that case, I'll check
> 
> @Jirka: Thank you for checking that! Please tell me if you want me to
> send a v2 or if you prefer to do that. I don't mind if you prefer to
> send your own patches, as long as there is a fix for that at the end :)
> 
> Note that if a warning is emitted for these new bpf_iter_css_task_*()
> functions, I guess you will have the same issue with bpf_iter_css_*()
> and probably others as mentioned in my commit message.

Arnd,
are you planning to send new version for your patch [1] ?
we have a patch collision ;-)

I can send v2 if needed.. so far I'm checking the change below

jirka


[1] https://lore.kernel.org/all/CAADnVQL-zoFPPOVu3nM981gKxRu7Q3G3LTRsKstJEeahpoR1RQ@mail.gmail.com/
---
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e46ac288a108..95449ea7cc1b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2564,15 +2564,17 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER_NEW | KF_RCU)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
+#ifdef CONFIG_CGROUPS
 BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
-BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
-BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
+#endif
+BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_RCU_PROTECTED)
+BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 59e747938bdb..e0d313114a5b 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -894,6 +894,8 @@ __bpf_kfunc void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it)
 
 __diag_pop();
 
+#ifdef CONFIG_CGROUPS
+
 struct bpf_iter_css_task {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
@@ -952,6 +954,8 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
 
 __diag_pop();
 
+#endif /* CONFIG_CGROUPS */
+
 struct bpf_iter_task {
 	__u64 __opaque[3];
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e42ce974b106..f2afb17a1534 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5421,7 +5421,9 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
 /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
 BTF_SET_START(rcu_protected_types)
 BTF_ID(struct, prog_test_ref_kfunc)
+#ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
+#endif
 BTF_ID(struct, bpf_cpumask)
 BTF_ID(struct, task_struct)
 BTF_SET_END(rcu_protected_types)
@@ -10873,7 +10875,9 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+#ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
+#endif
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10899,7 +10903,11 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+#ifdef CONFIG_CGROUPS
 BTF_ID(func, bpf_iter_css_task_new)
+#else
+BTF_ID_UNUSED
+#endif
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
