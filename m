Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5C2915
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 10:08:58 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-75e4497597cso79536485a.2
        for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686650937; x=1689242937;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enIbgg6959N2G6RdpoHIj5tDD/9w8gG//LMS+iH0xag=;
        b=BbU7swAqAUIsPP0uBZcWFjI++/An8VsqZgXjYAwrNkLc+Wnqnjv65YucMrSJeYuIZc
         IZyVuGbFSQpWbhzZNz9mtQaSPmfRBo2wExdxttdqKhoPEb8+oGy4os/Sy1z1RZkARwwQ
         SJwkYpn8r30MuvYf6CLwz2MvY7QvL26g8xgonkUU/QGdRRM+NrumFf+1CNQcxE2nwvHv
         7ekUDaRmUpUlRfhOsn3NYcmSfOUNi6wbkwcMbRHKwQJ8RV7CvfOW7Rfh1SHLJHaLeEC1
         SOgm4KVfgs2GC6p7csMbiyoF1SPeP9317rNDaF986VRzi9z1npsgMZ8S4y423VrbvQFu
         Sy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686650937; x=1689242937;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=enIbgg6959N2G6RdpoHIj5tDD/9w8gG//LMS+iH0xag=;
        b=caVqS+rGp6CsrHux/fm4HtRQHepZG8dDGZmGPFTqghUzJn4roLfztVRBqxDc+cng23
         qsIkjHYdNGbib/m833R3gCqbZyAJjxAH7iDVOJAGYWGsqRLYws90+t2rScShI9qhciO1
         GZcfOpFuaxWhQa63r+JZ+OUtP5ELnscS62N+PKbSyvpgr5dNqb/uSDRd32DQAN2jABhq
         cBFYr35WrKMi2X7llKkRYZzXCa+kLRvVePQNRFWHLwlc2LPdpNiEMwBFTDi6t3/seRrE
         9oT8qkF3gp83hLZfh1dVG9siP8u+Ve7Ra4rOb5hvhk7a0rk9/f9qB9rj7hTJJPbjklvG
         twqQ==
X-Gm-Message-State: AC+VfDxO+LSdoyJAcBImQsQs++PM2sYGWdT3usHm/l/fhtePc96o3uQX
	RPGbU0jyM+Js7uthxnGk3J2HIeqGd+hW
X-Google-Smtp-Source: ACHHUZ4OMsJysASX+OSC5zJCobG2kF8cx94+iT8cLGRNOqMQW/vbbfZIvLtIvyJY8pSyGUiomWDI6w==
X-Received: by 2002:a05:620a:6282:b0:75d:96a5:e53 with SMTP id ov2-20020a05620a628200b0075d96a50e53mr11274698qkn.9.1686650937075;
        Tue, 13 Jun 2023 03:08:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.125.133])
        by smtp.gmail.com with ESMTPSA id f27-20020a05620a15bb00b0075d405f4bdcsm1985773qkk.125.2023.06.13.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:08:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
References:
 <d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_stale test: Build Failure
Message-ID: <85d9e46c-e840-27b5-db29-db18dc579467@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jun 2023 10:08:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/d589a11c6bbdb9d452fa9c32d2c50d7e4bcd5444.1686202841=
.git.geliang.tang@suse.com/
  https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/5253908797

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/08b13e6560=
ac

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
