Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721323214
	for <mptcp@lists.linux.dev>; Tue, 10 Jan 2023 09:20:28 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id x10so13675167edd.10
        for <mptcp@lists.linux.dev>; Tue, 10 Jan 2023 01:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3E8HTqjSxihjroa/NP/h0G4LTRbefMJK3onrGX2JSfM=;
        b=miGRK3kyMiyaKoSBUmRa9OBV2e/Y6RZ09MG3cl6pdvaKRqJx8CwqZyvJZRSJUE7wQC
         GTLiS+xrTpteX1pNzsOF2fM7/WFh/rKPeNvfK4l3Z6bT63c/2kyaL2x1XmJuOFfcpfi0
         6i6Db5UkNiRVAbZRdgRlvLu9tG97tl4xCQw0d8/8KE5/mF1r9209EtSSZUslGWwhRKpm
         Nx1qhwVjAakyeKdpyA1M/WM7DeEoZ8umuLHM48N5LsrpNno2kvFIvJSPCAuPIZqJexjO
         7Kt25lto+M0kLO6Cc7Et5gXdDdhcEz3slu7fhgd8YTzluKGidZ1qO9l3LH1LJ/582Qw0
         WXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3E8HTqjSxihjroa/NP/h0G4LTRbefMJK3onrGX2JSfM=;
        b=6lAcSgnIIC7r4iaJGk/eqJa3haqVxYJ1v42vGrCJaGJPvl4eKXYyRZfDInKX4mtgQc
         +nThBxm9CKcmUMw6UGjHeMtBYk340g7wCwvGGM7QvoSmJwgdVv7hFj3IEhyt3TGTxEDn
         oIXGfT0ivRT0b2yRL7W5DqSevQyBglOvMfIh95kxFfiPUJPv6PtT+auWuoHRI5b3Q5zW
         v0BiJst/fxMg/xjkXpa97EHzd1nVH4ZgDha+4ZxqZ43bf33GVRCe1LcQPAm42Zc1pexs
         ye6Fj68/FH06pcH5/E1EMyguS/WHVmAB290uNKax9x6IJhH3nP0cnk3xW20NMHeTDUas
         p4oA==
X-Gm-Message-State: AFqh2kp/Biffw4NbhqleeLbxdGOGYLdRWL2GvxLb6L2paLxEt40mRCaI
	hFgNi+K1JC8hwRPR3CMWjVHlVdTI7lVKN4En
X-Google-Smtp-Source: AMrXdXsCPZe9n+c8pJd3U5swxczQX50kK+nx47UATJbyv/fG0fwpOXDtBEeUZkv2zWAfB3nXAN+S6w==
X-Received: by 2002:a05:6402:34f:b0:461:57c1:84ea with SMTP id r15-20020a056402034f00b0046157c184eamr60228476edw.3.1673342426099;
        Tue, 10 Jan 2023 01:20:26 -0800 (PST)
Received: from [192.168.113.205] ([109.139.161.100])
        by smtp.gmail.com with ESMTPSA id e21-20020aa7d7d5000000b0048ca2b6c370sm4679077eds.29.2023.01.10.01.20.25
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:20:25 -0800 (PST)
Message-ID: <862d1f2a-7c28-b740-7ff5-bcd5e13a6802@tessares.net>
Date: Tue, 10 Jan 2023 10:20:25 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mptcp-next v5 07/12] mptcp: remove assigned but unused
 value
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
 <20230104171526.1416746-8-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230104171526.1416746-8-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 04/01/2023 18:15, Matthieu Baerts wrote:
> 'ret' is always set later before being used.
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/mptcp/pm_userspace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index ea6ad9da7493..be389dad3f0a 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -34,7 +34,7 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	struct mptcp_pm_addr_entry *e;
>  	bool addr_match = false;
>  	bool id_match = false;
> -	int ret = -EINVAL;
> +	int ret;

I don't know how I got the warning nor how I missed that but as reported
by the kernel test robot, "ret" could be used unassigned below. So I'm
going to revert this patch directly in our tree, sorry for the noise.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
