Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DBC7A
	for <mptcp@lists.linux.dev>; Thu,  3 Mar 2022 08:44:55 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id q17so5636678edd.4
        for <mptcp@lists.linux.dev>; Thu, 03 Mar 2022 00:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TZC1qZ+oKDdbr4aGRGORlJR5SuxlFCrw6m5aX+rhetQ=;
        b=iMJIxhd9rC/Sut7dxpvgjZ6lYIZQhCrz0gYyWa483gMW6wynmwHkMVCQCB4iXzn1ji
         g4gRSpWuekYd6k1XgjnSpD9BNs0gCDrP1dSyYLJ54g44KXvdOUuDxO+VIFSXvdGfn0fD
         OUO+7LuKprQmMZY9/rD/oYSVBn478uNIFxJJ6N2o4YkuIkPvyHs0wejW9PY0OlI7dX2h
         n5LJgQUGg6cUUwuj4pExqIrHIhub8P+2Z2i4806bsbUg9Q7Im+l4ZiEHz/kBqS4yNYAp
         HvIvCCtFGJTXAgrRe8IR3vlVH3k39c+0VJp8lxY7A/4snI04IrPdZJfg3kLocEDKq3li
         bV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TZC1qZ+oKDdbr4aGRGORlJR5SuxlFCrw6m5aX+rhetQ=;
        b=nxRJqOXWB1gq0TdcpO0iLx/ZKyJJYGSivS9UjgdkivYkoSPIV2oCxXjJzd9R+muObk
         rYC9ouBlHK9y/R/AT8gGPFvvjiB4Yf5/EpWvDR7Sf8eiKrO6hN2impZWj00hdqUFsJfx
         a9bjnWCIWl9bFcii8EicYPosIQm1kQ979XMgMXPUUimhv/KQaqbSsd5slHYybi5MLsYX
         X7EmPWzkBgm2WvfmQ+O/pHNYxu5F/LXrppXl2ytCWITY7UqK0zA+mHYzslTlVHuqzBwO
         DBvl41npngZy9fzwJGTDpkxwHWbFVc0W3cHwc0jwsqTM0TN0HZovPdAEIJiBaWvsXSi8
         BO2w==
X-Gm-Message-State: AOAM531BSpsBlmtyvA01tGAMY31EDraVOiYQfozJ0wKv/Jf57Pk7vJUb
	OwjhIgHEdA3uZm6tgIdsoFj3jaGJohZxTQlf
X-Google-Smtp-Source: ABdhPJwUOlAh+Bd0S+f/WLpCv3sH3qunZzlV0K0+LydJqXiLufDntRdGC6WIhjofEHSRprvYiMzyfQ==
X-Received: by 2002:a05:6402:491:b0:413:6c2e:bb2c with SMTP id k17-20020a056402049100b004136c2ebb2cmr29341797edv.196.1646297093622;
        Thu, 03 Mar 2022 00:44:53 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9692:b15:c6e7:1c2e? ([2a02:578:8593:1200:9692:b15:c6e7:1c2e])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090672cf00b006d6e3c801absm463203ejl.153.2022.03.03.00.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 00:44:53 -0800 (PST)
Message-ID: <f3d4da00-5483-7da4-8890-d40df6ba34f4@tessares.net>
Date: Thu, 3 Mar 2022 09:44:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v4] Squash to "bpf: add 'bpf_mptcp_sock'
 structure and helper"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4a1d63bb7976c1d61308a875132107e17272c8f8.1645519631.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/02/2022 09:52, Geliang Tang wrote:
> This patch addressed to the comments in [1] from BPF maintainer Alexei:

(...)

> diff --git a/include/linux/net.h b/include/linux/net.h
> index ba736b457a06..9c1a634e5ac5 100644
> --- a/include/linux/net.h
> +++ b/include/linux/net.h
> @@ -238,6 +238,7 @@ int sock_recvmsg(struct socket *sock, struct msghdr *msg, int flags);
>  struct file *sock_alloc_file(struct socket *sock, int flags, const char *dname);
>  struct socket *sockfd_lookup(int fd, int *err);
>  struct socket *sock_from_file(struct file *file);
> +struct sock *msk_from_subflow(struct sock *sk);

Would it not be better to expose this in include/net/mptcp.h instead?
And prepend it with 'mptcp_' as it is exposed to the "outside world"?

  mptcp_sock_from_subflow()

But when thinking about that, maybe better to name it:

  bpf_mptcp_sock_from_subflow()

as the implementation is quite specific to BPF.

In this case, it should go in include/linux/bpf.h with the other
bpf_mptcp_ functions (with the #if/else CONFIG_MPTCP you need to avoid
compilation errors).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
