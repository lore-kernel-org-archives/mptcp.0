Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9F8F65
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 18:10:53 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id x5so6396958wrt.7
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 10:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29c5P2ejx556tKG/QBJZ7RPSrAmBBEUgleDRte9akLE=;
        b=UzZmgTcfrXFDPG57KDHo+laCJbC1GGYxsSpDwyO/cYNI+NUUiYtWuVAHldOxfsf7/5
         VmZcUkYldPkw6BqdTmAKFSbOYm137O+I6SjUk6SkuBIVvTqp5UWhqxdSuWfZLwhr47+V
         Pg55LqW4isqf8ny3bnGYhkBgu1WnL+jjJJ6AWunX7/YXLXQ9MMLyj+iZWuHCrH1sMvXi
         xzsx9/wOG9Q3Phlok8WQjpcWXp29eSIHCxkG0zy330TT6t3z7xwBbuxS7zKpOhP7TvhW
         UXxmt3AFxweQUupj4+WoVF20SJLryAa//npxoxmX11MCjbDIEo1VRboWbCix3qpfHTf/
         vdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29c5P2ejx556tKG/QBJZ7RPSrAmBBEUgleDRte9akLE=;
        b=yM1GT3WQDMRUt8Bqvp0tt42r2K+DbAq0teSGgDQG3RkIzvL5CKNB4Ye/AH26FYAb/K
         wdNAoGuCZhTXkq4Ysvlsu/lTR70pvxNS/Q1eyt9KGIs5MNYVh2+CqvutWKKTCZO5BaEx
         kO90z72qTaJVbEZnZgJPmy76XBJSmNqELxK2ZMpPiIhNpl82Wdjpn/KdaHMueRb/FbZb
         4HpV6MiJYJzaCP57xHt8joVLjy/Kj3xlPApA/eL58h/M9BrjM64ZT1aJEQt/lgEjCt8g
         lvFUzCpdhVOmdb3zlaaJqJdQA90OT44u6yrdHc3tgHQkSJwUk6BgeW57IHF2VoudM4d3
         kKqQ==
X-Gm-Message-State: ANoB5pmEhedzBDEJQm4E1ycnDpHKaiQTtUdAWJQHSVeoT8mSZ706FgJf
	P/NvS454hU5t0EPS2Ubq0Ah+QKumpKwsiQ==
X-Google-Smtp-Source: AA0mqf7rAIiOx2VfsYRtmDviSAwpuo8fgc8DLDfQypfZ8EgNEOo7mi70t0RwToJgXf1B449UR9u+lQ==
X-Received: by 2002:adf:de08:0:b0:236:e271:ead4 with SMTP id b8-20020adfde08000000b00236e271ead4mr4927408wrm.426.1668795051470;
        Fri, 18 Nov 2022 10:10:51 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a3442f1229sm10371565wms.29.2022.11.18.10.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 10:10:51 -0800 (PST)
Message-ID: <cb2a531a-02bf-9c80-5385-e02d9e61c368@tessares.net>
Date: Fri, 18 Nov 2022 19:10:50 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next v19 3/9] mptcp: add sched_data_set_contexts
 helper
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1668151131.git.geliang.tang@suse.com>
 <5ad9715e09a2acc245c7a504b086d6ff33b40a7e.1668151131.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5ad9715e09a2acc245c7a504b086d6ff33b40a7e.1668151131.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 11/11/2022 08:47, Geliang Tang wrote:
> Add a new helper mptcp_sched_data_set_contexts() to set the subflow
> pointers array in struct mptcp_sched_data. It will be invoked by the
> BPF schedulers to export the subflow pointers to the BPF contexts.

I have an issue with the CI and this commit: it adds a new helper which
is not used before before "selftests/bpf: Add mptcp sched structs" commit.

We then have this warning when compiling with W=1:

  $ make W=1 net/mptcp/sched.o
  net/mptcp/sched.c:97:6: warning: symbol
'mptcp_sched_data_set_contexts' was not declared. Should it be static?

I'm not sure what to do:
- modify the script to parse error and ignore it (I would prefer to
avoid case per case)
- move the commit after "selftests/bpf: Add mptcp sched structs" and
directly use it (extern + kfunc)
- squash it elsewhere?
- add a patch like that:

------------------- 8< -------------------
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..e9b1ff932a3b 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -94,6 +94,8 @@ void mptcp_subflow_set_scheduled(struct
mptcp_subflow_context *subflow,
        WRITE_ONCE(subflow->scheduled, scheduled);
 }

+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wmissing-prototypes"
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
                                   struct mptcp_sched_data *data)
 {
@@ -112,3 +114,4 @@ void mptcp_sched_data_set_contexts(const struct
mptcp_sock *msk,
        for (; i < MPTCP_SUBFLOWS_MAX; i++)
                data->contexts[i] = NULL;
 }
+#pragma GCC diagnostic pop
------------------- 8< -------------------

But well... :-)

I suggest to apply this patch for the moment to avoid errors with all
new patches and check later which solution to use.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
