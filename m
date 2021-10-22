Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2D68
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 07:22:08 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id a25so3581386edx.8
        for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RbxGn8rvlnJonem+I51mG2O5Nb4QJa213IRNxjEHDzc=;
        b=idoDBpxK3g/Y8jwFbbjLfCUbrdl3cfF4/Xt4dK/+g6y/v8Pm7vzJ1gjVy4+sGAGD3W
         RbMqC4MPYDKCXbTnyrEn1wR9qgqxcVHXVphUXHK2XhECVKm85EcVVSVIWrzH+q29ZpkL
         fubwFEEpamJCjVIDBqXmZfdp/1TB9e5+ZqIx9UzW4CP1Ce6U6+4IfUldbLP6kxxvMcH5
         HMM/pDb2wn02KOWQK/ryIPnM2E/DPc0qfJr0fT74HWwJH1zn53Mvi8dGbzVeV40ko7Zd
         VoYuDuzW0cOzCeV5QTkWYCcvT5i9pB89UkAPkBs1aG1zNfB79fok/K9mrllQIzIqeddA
         8HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RbxGn8rvlnJonem+I51mG2O5Nb4QJa213IRNxjEHDzc=;
        b=zrrJGunA5m07svr56f3FZZ2cpE2OVuO92u7Qm5HK6FZk6kb7sX+tNYjVU6EXuguk0T
         YjDa4bHiVMCJIapBBxFWXgWAHrKNHuXFI3BgY+CFM/9gvjIFbXtTxWlIIeDPOu8zJOst
         lHItpOypVt+2ceMWvPJDuy9trE9SSk2zkXisWh7lOdLT+X/Hz4bkpAkxDNkTM6wzagDo
         IYdCaWHNJIT0noDleeMgcuJoeUGw1yJ6IfovRsfnux5QuhFOE0AYg9bwXW/izFE8cEZU
         0Sw9gWVauOw5pb8BUpisCCTFxeFt50ZdbnXV2L+L9Xkgdffyqny7nBso1sHFACkY48Cs
         9JAg==
X-Gm-Message-State: AOAM533kFfipkjcBfRQPjgzhrTk7CjrhoEABSyGcdwsQzxmZtxRpW437
	Ft1xRaeE1GV7uf3yhxGHoFZS5A==
X-Google-Smtp-Source: ABdhPJwyL+UItn/YEDXHshQ+g0TJKkj60vQsd6GMIX84mKyStSO7wVN78j7AE77Ap/h6l+ACVM7I5A==
X-Received: by 2002:a05:6402:4308:: with SMTP id m8mr14709732edc.188.1634887327088;
        Fri, 22 Oct 2021 00:22:07 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id j21sm3824944edr.64.2021.10.22.00.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 00:22:06 -0700 (PDT)
Message-ID: <7323f833-08e7-5b90-6175-c88696b73e63@tessares.net>
Date: Fri, 22 Oct 2021 09:22:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH net-next v1] net: mptcp, Fast Open Mechanism
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>,
 mathewjmartineau <mathew.j.martineau@linux.intel.com>
Cc: Davem <davem@davemloft.net>, Kuba <kuba@kernel.org>,
 mptcp <mptcp@lists.linux.dev>, netdev <netdev@vger.kernel.org>
References: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmytro,

On 22/10/2021 07:15, Dmytro Shytyi wrote:
> This set of patches will bring "Fast Open" Option support to MPTCP.
> The aim of Fast Open Mechanism is to eliminate one round trip 
> time from a TCP conversation by allowing data to be included as 
> part of the SYN segment that initiates the connection. 
> 
> IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.
> 
> [PATCH v1] includes "client" partial support for :
> 1. send request for cookie;
> 2. send syn+data+cookie.

Thank you for working on that and sharing this patch with us!

It looks like some modifications are going to be needed, e.g. after a
very quick look, it seems all tabs have been converted to spaces causing
the patch not being applicable on git[1]: did you not use git
format-patch to generate it? Also, some issues will be reported by
checkpatch.pl, the "reversed XMas tree" order is not respected for
variables declaration, etc.

Do you mind if we continue the discussion on MPTCP mailing list only? In
other words, without Netdev mailing list and Net maintainers, not to
bother everybody for MPTCP specific stuff?

Our usual way of working for MPTCP patches is to have the code review on
MPTCP ML only, then apply accepted patches in our tree first and once a
validation has been done, send patches later to Netdev ML for inclusion
in the -net or net-next tree.

Cheers,
Matt

[1]
https://patchew.org/logs/17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net/git/
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
