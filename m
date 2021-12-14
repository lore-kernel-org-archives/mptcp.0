Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED677168
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 16:10:32 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id x15so65734701edv.1
        for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 08:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=pAXGjA+/HsNllXTduI38yhAL2rcTzsr2halWgzOgyZc=;
        b=iuoNi06ki0yGOQwwJeiD+73RrDlf7pykoxV0YOafQYZh9Cocl14X4g0yDxt3voXJWs
         Yywc3/w9xs35t0N7B6myVT65a4H43oTlQ1pTXk/wq3p8YzfyOLnm8jyMx2EI70edJQ8V
         ytiuOMo9DyN+i0HQtDBKtMX4URubB87ZA3RvLix7KHJmy6nqvVWwrFRJ3bH1ljWqWHOm
         MCdo6kbjXYezE/W6u/hta4Zz0wntAP+D8k8CpS4hUp+p5u5BIQK8IqMJwI7nBnmf32rg
         4Yh6dZEYFLgyeM1BU0XTY28SLFghGWj4hV4wcFGbPzN9tQ65f8urbDc1iHxvC/OsGFFp
         RiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pAXGjA+/HsNllXTduI38yhAL2rcTzsr2halWgzOgyZc=;
        b=ZR81DZAtQeG9fH+WHJBLgTFaoGUauswbhxPJXBN8ovwJuIGnKNmZ3q7mQLFOTWfpLT
         vM1Td4kl/pLX77/Tx9qpAm5+02DQMf5sE3ZrRp9/Eg1k3dxL7wETKWkjP9y206/juqKz
         bea+z62taa7hikgXwZB18cwaf8vD03rOM5bVA6Tc5e2xVOZ+xhwmC+BokctbSHKM0UTc
         MuT+ZPUxyXmQFqqS7QhuGdNlh83g6c1FaZ+K9N2HFY1nkN1Ns/UcBp/GLlgDdxmCQ5lV
         2tNx129rHIzGrScgPDxFcPQ5X3jfoOe4ILDmUbF7KP9rH8RYfTtmZEL4aLOaMeZY0tNd
         b+Pw==
X-Gm-Message-State: AOAM530N3niIuCM7/VMe1MDg4UeeV+PP1NYpLw8vvTQQkBfmKIoeOIRF
	LcGwGzklk6z0SrFGalQpBd/vgQ==
X-Google-Smtp-Source: ABdhPJyQrockf9I2wTk3S4dUxP3IC6VMcKN8NFwD3MNsXwp2nwkZVYUhj0nwIvmYX1VQMPeAqFg0nQ==
X-Received: by 2002:a05:6402:350e:: with SMTP id b14mr9250689edd.313.1639498230873;
        Tue, 14 Dec 2021 08:10:30 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:6ccb:ff63:52c1:4a46? ([2a02:578:8593:1200:6ccb:ff63:52c1:4a46])
        by smtp.gmail.com with ESMTPSA id hu7sm63010ejc.62.2021.12.14.08.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 08:10:30 -0800 (PST)
Message-ID: <d036fee5-90f2-30f2-e4eb-e1a917f1b304@tessares.net>
Date: Tue, 14 Dec 2021 17:10:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 net-next] net: mptcp: clean up harmless false
 expressions
Content-Language: en-GB
To: =?UTF-8?Q?J=ce=b5an_Sacren?= <sakiwit@gmail.com>,
 mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev
References: <20211210230245.342764-1-sakiwit@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211210230245.342764-1-sakiwit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jean,

On 11/12/2021 00:24, Jεan Sacren wrote:
> From: Jean Sacren <sakiwit@gmail.com>
> 
> entry->addr.id is u8 with a range from 0 to 255 and MAX_ADDR_ID is 255.
> We should drop both false expressions of (entry->addr.id > MAX_ADDR_ID).

Thank you for the new version!

Now in our tree with Mat and my RvB tag:

- 51708fedab61: net: mptcp: clean up harmless false expressions

- d41488e31d8a: tg:msg: remove 'net:' as it is an 'mptcp' patch
- Results: f4539ed375ce..3fa476cdb0a9

This patch will be sent later to netdev for inclusion in net-next with
other patches.

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211214T160950

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
