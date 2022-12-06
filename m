Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F7A2F2E
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 11:00:45 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id vp12so5249038ejc.8
        for <mptcp@lists.linux.dev>; Tue, 06 Dec 2022 03:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgzCH7hmFFkmGRbOGnzhF0U7QzL2mZ6msG/ICtNfg2I=;
        b=NNxHWON0I6jPNyLKi08XLy8J/UCRcdSJuBjaJKKdb0MOMCT29qKBMlgIVo40Cr9/2l
         rnFEYYGaX0oQB7Bk1pCQKmCiq7DbjVcJBVEyzuamnWEI0G37IksSvDmEFFTvSN/zU1Cc
         a4i3NY8pMCuez+gmojtTBogay1A7uf8UO13lotDFAZAWNDLK+k/9SdU5/glAvW3ltnjN
         FOLg60MWNbInN/e1uzVAL5kDL2oYFe+B8UhQajPgLfq1bx23VW1hntFNHvVtfXNNgaVq
         TWihy9b81RPWQOFze6L4p3QQ15aOGHA5g/B1Ek+ETJmfTv5fMqxviMxO+lxFIC7BsVVY
         FP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgzCH7hmFFkmGRbOGnzhF0U7QzL2mZ6msG/ICtNfg2I=;
        b=0eBnuZAETDdVRo4WFoBIzYKyg/zNNIsC15hh3V0hIs5xoAhY2INGNR5AkvP8j2EIbo
         TDKtNZfoFJeNXD7lOIFCtq+V7Bx74s9euQ6p+w5Np4GqSwg58b6nHqgcQnZpxUWuMWIm
         QXguVLus++3yzieigqEFRH1fRKcaLyojDiOrUE13JF+625q/jUSR62MOLGMWM5itoAQR
         Hj/d/9u7usPZq+kfHPnCKfvgjoLEkPe4ARh786aZ0ueIY3ghP3yW5M9vDq6NQp3MxR3b
         fA2gbRtFHcjvwutUYgvJmxusvsZ6kcS1/a3dumo7+rX+u31q6y+Vc6YsQ/pLZkUMLuAp
         cPfg==
X-Gm-Message-State: ANoB5pnycDfLRuovVKdLnGfFikg4wEYV4j+3dZjrdkaMAnCogSyW/q0X
	Dx1gbERZVCTR3tNHYeFfT8ky6Q12bLapCJfs
X-Google-Smtp-Source: AA0mqf5YBfKiCAcgerrRBQK5dkOM0PTFwRG6PcxBDiR4GFy6w0QVBe4XAislDcNKrbBr1NCt4kceeQ==
X-Received: by 2002:a17:906:2554:b0:7c0:db53:c599 with SMTP id j20-20020a170906255400b007c0db53c599mr94117ejb.22.1670324444173;
        Tue, 06 Dec 2022 03:00:44 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id va13-20020a17090711cd00b007c09d37eac7sm7238832ejb.216.2022.12.06.03.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 03:00:43 -0800 (PST)
Message-ID: <5f7fd533-88e8-277b-5a9a-0dc6bb9bd1ce@tessares.net>
Date: Tue, 6 Dec 2022 12:00:43 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 mptcp-net] mptcp: fix deadlock in fastopen error path.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <f594fa95592f25434e24f0d16033cda1af9ce2cc.1670272505.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f594fa95592f25434e24f0d16033cda1af9ce2cc.1670272505.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 05/12/2022 21:44, Paolo Abeni wrote:
> MatM reported a deadlock at fastopening time:

(...)

> In the error path, tcp_sendmsg_fastopen() ends-up calling
> mptcp_disconnect(), and the latter tries to close each
> subflow, acquring the socket lock on each of them.
> 
> At fastopen time, we have a single subflow, and such subflow
> socket lock is already held by the called, causing the deadlock.
> 
> We already track the 'fastopen in progress' status inside the msk
> socket. Use it to address the issue, making mptcp_disconnect() a
> no op when invoked from the fastopen (error) path and doing the
> relevant cleanup after releasing the subflow socket lock.
> 
> While at the above, rename the fastopen status bit to something
> more meaningful.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/321
> Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Fixes: fa9e57468aa1 ("mptcp: fix abba deadlock on fastopen")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - Fixes -> Closes (MatM)
>  - fix style issue - missing brackets (MatM)
>  - fix code comment typo
>  - fix pktdrill failures (ret != -EINPROGRESS -> ret && ret !=
>    -EINPROGRESS)

Thank you for the patch and the review!

Now in our tree (fixes for -net) with Mat's RvB tag and without a typo
spot by codespell:


New patches for t/upstream-net and t/upstream:
- 46a9518f3d44: mptcp: fix deadlock in fastopen error path
- Results: d548986b0c83..8def2e2cb0cb (export-net)
- Results: 9d2a0e3ede73..c7fdd02a4241 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20221206T105822
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221206T105822


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
