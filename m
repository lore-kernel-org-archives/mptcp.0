Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AF371
	for <mptcp@lists.linux.dev>; Mon, 25 Jul 2022 07:56:12 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id u5so14773749wrm.4
        for <mptcp@lists.linux.dev>; Mon, 25 Jul 2022 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jKPzbLdofNDAKFROvbyaXWCJpu3rtiOCogHEt6dL2f0=;
        b=lgQhXNFy3tlObbhvzoEonLo3QD6dOVGQ/lEXif3eIacMkCeUVx0CE0YEVnfeT6rUjf
         tOOXexLWuEg3GfgYsSsb/b+Fc25VMLJQeWrNnneMHKN6n+zzx04qFS+2LDz8NgWfMdKM
         DdqgS3Qhw1JQszfTRK4cMT/qfvhV/cA1upPb7DZmIyJEikrQx6onPtO2t7IEHroDK1Aq
         Vw8acxC5gq3Bgkqh1qKrqhxt33LW/A60PntkiPiog8cKaosuMq4W4LbFAJSWOcyjbnTY
         VO6eUdnBQqAhOZmfTz9kXtvW1+gEv8Eeq8WmRMApfjEiYPOu6c8e8Oql8HdAQI1Mb7QE
         V/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jKPzbLdofNDAKFROvbyaXWCJpu3rtiOCogHEt6dL2f0=;
        b=X5sWc1edd9T/rdjyt5Bm+vamtUoCACsQgPXtNRYtKniaLhCa5jxRXBAD9bIWWsMoyg
         a0Lgwwc2H0RBXxclgP9iPc53z/0VKZmkIVA+m7q0IztPAmG3Ggn2r9gqGlnriIWLf4jK
         KWINocpREOQJhe+INrYY5Txgwa8Ylpnfa2efJaJmfMLpR31AV73tYwdUxSm6J4RqZoBt
         +ykYZweH5ZG6Cd9Qg90thoqeaWA55pfXofZ01nIl0fDgWGhGOtI/YR/VFP6bD8qHhHQy
         S95VLGZx9Wbp8bsXPMl5kOkKEaftE1gm/YaOiVHZ3reHkCpIJH6lEwzcyUZKdOW/7noq
         KHkg==
X-Gm-Message-State: AJIora/64W9tBUrRX3FjeysNIwxMQIGPKfwksfuLsWvq0f6rYrIi6BDk
	qXHBO3wRpExX7J4oIKL2hq+3WQ==
X-Google-Smtp-Source: AGRyM1vhUNMRrDq4y4TgR+IJXJmBsh/t5ha4fzk8o/A49IevhYVO8yUeVbOHC/aUM5XMO5jJP2+Xug==
X-Received: by 2002:a5d:67ca:0:b0:21e:5ba8:a067 with SMTP id n10-20020a5d67ca000000b0021e5ba8a067mr7064695wrw.650.1658735770891;
        Mon, 25 Jul 2022 00:56:10 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0021e50971147sm11077720wrl.44.2022.07.25.00.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 00:56:10 -0700 (PDT)
Message-ID: <20afdb4f-2aaf-5a2f-4472-e4dc35b2f8ad@tessares.net>
Date: Mon, 25 Jul 2022 09:56:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH mptcp-next v7 06/13] bpf: Add bpf_mptcp_sched_kfunc_set
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1654143895.git.geliang.tang@suse.com>
 <d246b0ca7372421c3bf31cffdf4151b2b6cc5dcc.1654143895.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d246b0ca7372421c3bf31cffdf4151b2b6cc5dcc.1654143895.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 02/06/2022 06:53, Geliang Tang wrote:
> This patch adds a new struct btf_kfunc_id_set for MPTCP scheduler. Add
> mptcp_subflow_set_scheduled() helper into this id_set, and register it
> in bpf_mptcp_sched_kfunc_init() to make sure this helper can be accessed
> from the BPF context.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/bpf.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 0529e70d53b1..e86dff4272d5 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -161,6 +161,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
>  	.init		= bpf_mptcp_sched_init,
>  	.name		= "mptcp_sched_ops",
>  };
> +
> +BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
> +BTF_ID(func, mptcp_subflow_set_scheduled)
> +BTF_SET_END(bpf_mptcp_sched_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
> +	.owner		= THIS_MODULE,
> +	.check_set	= &bpf_mptcp_sched_kfunc_ids,

FYI, I had to change this commit in our tree, see 556f2a5949dd ("mptcp:
bpf: fix compilation error").

In short, I had to adapt the code due to modification on BPF side,
related to commit a4703e318432 ("bpf: Switch to new kfunc flags
infrastructure"). I hope I did the proper modification.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
