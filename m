Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C9362
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 00:08:33 +0000 (UTC)
Received: by mail-qk1-f174.google.com with SMTP id t207so2202925qke.2
        for <mptcp@lists.linux.dev>; Thu, 07 Apr 2022 17:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GCUbdBxeEn95SjrNXfQh+HNZlgF82IXYyseq/08BKl8=;
        b=gfX/tbLa9Xol9i7zT4AwNI2VNwpQP2tdOJPoldtRrfq+8EGAjyu0SCDjy0mT7NIu2r
         YyD9mjT1bl8iX6rpwud0Sx1JYNNNcEO3XrhbvoeOlcFCBPb3Yst24+6YtpRXkyDwtNa4
         pMG8dJecdfeenYR+3pB1nZkk0fjzRglVCK8/k9apj2VeJ2D4CqAWeoCUUhaoWix1TGs6
         dwBhYSA/i1MWA3s6MvIA5P270zUajUIE08IIr2zQNBiRhKlbOMCZi/qNwKvXH9ZrkEgT
         5JViUshPxtpMXxvwmR9VtOwFeWnIbyRVndUzFnTefY8Sq5ygJmnYbWKY4DuVoHim9b9n
         89Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GCUbdBxeEn95SjrNXfQh+HNZlgF82IXYyseq/08BKl8=;
        b=SOHBE65TFODB2QeDJjz7CftWnydupeDeGQMU4c9r891ekes7EEeB9W3ReYCNfvoLkh
         XKuXafssCgol4WagHh20rHNTI5TSrdwktKdawAsG+adqn8diTE03eeUcnZhM69JANJGt
         zZ9e+T/jMP0cJkhu4Iiqzc5ZHvYmR5u4nWNHrOSZ//k3uuD//0QywZpsc9S6BaPu8l6N
         lAdPMr3jrOq2LOvjf1WJL3bwkDB3JiszfJDbax0DtdbcLyz8pttYYT5bVpB+Y9AmTin0
         sFf4/pDn0ikYNp7xlEDyVnIOphbDLgnwZSKjqJaGr42rcubLd35Z+kTZsarGCB5UyQk8
         DPhg==
X-Gm-Message-State: AOAM532A4l8SUdlHE1bC6VLxKSWMWQHLBvYLMNbv69NTnYyJWkrmE45h
	UnnddGF3RuY4OhamDKBnNA==
X-Google-Smtp-Source: ABdhPJyb83UdvSyrWv0uUv8Jzej1kBNGs05Jzyw9pFMAiO5f/UWIvF+iXFEg8BDDzdfGNh+D9NtJag==
X-Received: by 2002:a05:620a:2442:b0:67f:65f6:bad2 with SMTP id h2-20020a05620a244200b0067f65f6bad2mr11577440qkn.203.1649376512718;
        Thu, 07 Apr 2022 17:08:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.22.236.228])
        by smtp.gmail.com with ESMTPSA id v67-20020a379346000000b0069bdb3bb132sm79791qkd.37.2022.04.07.17.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 17:08:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220407234029.1774481-15-kishen.maloor@intel.com>
References: <20220407234029.1774481-15-kishen.maloor@intel.com>
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Build Failure
Message-ID: <bdb2bf3f-031d-e4fa-c8c7-45ea237248a3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Apr 2022 00:08:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kishen,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20220407234029.1774481-15-kishen.maloor@intel.com/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2112210011

Status: failure
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2c3fdb5eab10

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
