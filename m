Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335C870
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 13:42:59 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id kt15so24872238ejb.12
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 06:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GDhyIMR78gf/AFBazxuTdNY63RqDpU+kGdvOKtMTLl8=;
        b=axji6VP/60W89xcrthE836hJ8xL69vmwwdLaYPf3yhnhYVJuqnP4elgSO7o3Ie3+k2
         DHEmot74/d7wT/2/HSTEnmJHSxXE6YDnWahVQGKnFiLLVA3J8q3x2/tk8e/yDttr80mh
         RmAWk56HeHcBZPxLhBxOZKhFsY2ndLYdSrTRoLmEeOGF5N7ua4KqeuEdsWQa9FbT2jNE
         QnQxRXe++88IxX2pwbR0PI30CKeE1WZottOevwV+I2xH700jWsptq9YoSJqAPWxe23K6
         PYZW7UTET3d4B+ri6tONwGjUuyy6YVMi+gGJBVvxzuOc6+2NIZquA2P9gWGKMnfZ25FD
         rw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GDhyIMR78gf/AFBazxuTdNY63RqDpU+kGdvOKtMTLl8=;
        b=QBVbXnFlKt3OMCLvxRlBqMCx+wT6nl6vNBHGQa+3VBBColJm7C6HmyACsLmMUlnQRj
         7G4wYG09qMIAmqHHTmzFtSGvfeltgnz0ga6u2bcmDWvZqj/feb/SFjmBCrJ/OfmIubYM
         k9OQJvp0VJXnzYYRjEVn90gq9YjQq/VpHlfUQvvMMiXJUlTdTfKR7E+5qPETuG2LR1jL
         vAwT/fHh0GtYHx97hNFYAcqsZ6V79TrehENLs2u3ftmY+fVXhgVkkLcrmbR8Ek1QPY5u
         bxd41BS84nmgUrVbr4VGlk1HwkGl7EO1Nfqe+TyMhuQezvBzeYLQHEr3eWVSt6/DDYGm
         IIXg==
X-Gm-Message-State: AOAM531lxvv8Q9lWKUWFuGzZG9U7B6x4dP5GYYoXCmc38hejNy7EiHJ/
	F3giE15yGKcrps8KTPyOmAhGdJP0GasZ9Q==
X-Google-Smtp-Source: ABdhPJxoLo5FIPiPB/2WQ5hZzsJ1opeAyf9QF+uN6aXmoVpK8uQQdC9HKFx7YhwfPB96FNDBg64Idg==
X-Received: by 2002:a17:906:80ca:: with SMTP id a10mr33663260ejx.297.1617111778094;
        Tue, 30 Mar 2021 06:42:58 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8c77:a440:107c:fad8])
        by smtp.gmail.com with ESMTPSA id jv19sm10213929ejc.74.2021.03.30.06.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 06:42:57 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remove id 0 address":
 reverse Xmas tree order
To: Geliang Tang <geliangtang@gmail.com>
References: <fdf6bc5a67730afe487dcd7b916c12dfb51e6177.1617091295.git.geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <d3b40d16-09e1-542f-c6d4-876f834ed1b8@tessares.net>
Date: Tue, 30 Mar 2021 15:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fdf6bc5a67730afe487dcd7b916c12dfb51e6177.1617091295.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/03/2021 10:02, Geliang Tang wrote:
> Ues the "reverse Xmas tree" order.

Good catch!

Now in our repo:

- c941e73cc7dc: "squashed" in "mptcp: remove id 0 address"
- Results: ee61d54be9fd..a238b5e19fcb

Tests + export are in progress!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
