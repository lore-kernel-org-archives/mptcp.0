Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F722C86D
	for <mptcp@lists.linux.dev>; Sat, 20 Jun 2026 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781915412; cv=none; b=K2cGP4KWQAztKCkfuuq4wG5kHl+SmGolbIdUJ34bJUHJ9TkbeglBQDGPvsf+gohD0DiZ6CMg5q/sFOB6N/FEYga55//A7GcwkYnZI51l+ltzQNU7ml0lUWWR8++cefKLyNCkn8ag7q7wawHRRIAGuvoX0TbqYqItGcZzaHqWe98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781915412; c=relaxed/simple;
	bh=s+ThBPJjZSx2UN38w42RRLyvdrXPx0i+Kc1D769GWRc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GttkZxbzyBN6KPtQVFAK+jwErd07anfWyJdNrRZogAOrCrho3cq5yyeTHn8gMwMYw1B81HY1AxpBbGN+kIj2f9CIDpqAkbEDnQTJJuEdjM20tTsFjiSMfGNeaJB55WGoUmbSM9AIhgyTWUrhHNkQdmCNJFZkTW+W+HCQRHyx5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgBxYmP/; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgBxYmP/"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1363fe80fe8so3464184c88.0
        for <mptcp@lists.linux.dev>; Fri, 19 Jun 2026 17:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781915410; x=1782520210; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZFCYnWt7IA48KpX8ZVKEBNiiz93nw5S/vAvNwMhIMg=;
        b=hgBxYmP/MvrsIjAXOk5KOQxGhDaGOk6RBgDhVDmFjGt9CQOZX6aCpQ1H85fGtimRK4
         ul0Z3QRUxtHko5KYSq6dHz6p+c03+AeIUwiiONqHX+BXNHNVP8cKSB/+lYKOC7Xwta07
         9LDpt6fS28jCN5ZoYHvyi7ZSZSBmyV5LIybzc8o6OPHkivEhVMwSpxjvGZfqnZfxT3Vj
         99ncAmW1iSS8+jES3HDlM58vubYMcBrPt8rhQhGqWWGTkpyqRWQg5WBmnQ0FQj+ftp5Y
         cJ1s5t80T6StX3acGb3F+1wnLfIpR+Ei29ZtCa5smbjA7fNzIWSOzpV1lBqRmnluA/Qr
         NPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781915410; x=1782520210;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZFCYnWt7IA48KpX8ZVKEBNiiz93nw5S/vAvNwMhIMg=;
        b=JTG3jByQKHk37rGERRlciQpBqR2JkmoOvdRnpAoRn1AE4Qoql5N1L5ju6xTjHaYWHm
         fVdEz76yFidmf9Z/B5jCV4GT+JOqditmPC6Ptizon+y0yI5Y1RTfLSffvudOP8FWOIcU
         UQPlyeBhWPfAfVXGMtLTH8+IrlFuT+AYCDAEX66akU50BQb0pYwCANIsiLzwV0zVpY5G
         whYIaQpUhcMMehbMG865ImNLv64l58mZkrY1+SclAshVEskqEWTZQuznwbwVaBBD0HFN
         WfYuqAI/JEKdoWUxdOgXAUjqXS6Sn+YiKWZCV+9LJ3XmzP7ToyqFruagOXGbe7eD+Hb2
         mE+A==
X-Gm-Message-State: AOJu0Yz/j08ihmzHLhWR88FAe1H8bdBwSZ3/hmiTHXoK8hnWTmPLVO6O
	HPAYUvXMKg4kG+D2yekV7SAHrjdskKJlQSVG52Yf5cMoRNs6vHNGRZqu0Ura
X-Gm-Gg: AfdE7ckGJdSQe+kqW8ApsvIFueVjD8V8NREDmhGhICzixScLl22qcu9ePIS4GL0X4F9
	DWGDFX2HgQnFM5DcNF8Zu9Kl1QnhqgbmrxJhZtAJx5q00scYByLbEg8g/9RTEw/X3QrEZCn0YpC
	pRadS9FcY7zouRSOhPXlxqE6OrWSlaajxcdfAFDIBivHDwE+OS8J5dmc6HPq7fKf6QDNz2gW3BT
	GhQCHcuL/3K7fUidry134JchcI7FITdqqDjQ8kY9LRziz+pie/UOXaX1d+WoaluChbdOcaN7WiS
	A5TA9tveLSsvlgxyXO+Lr0Gc98Cw/2Deg8siHduHh4r5BAf920Z0aCOfb12ifps93GCWgAulZAB
	rsD0BI3Kx6Gl0bxDxax5FbPDR4xVjs4a2Hzk28fL1obuMCT48N69XKqU9Q7MkgOfOazv0kpojE+
	nLHlnhXvI2iaTR7NTRkrTwlnqd
X-Received: by 2002:a05:7022:6894:b0:137:e6a9:b998 with SMTP id a92af1059eb24-139a38812ccmr2468836c88.31.1781915410151;
        Fri, 19 Jun 2026 17:30:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.64.25.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcce488sm834508c88.8.2026.06.19.17.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 17:30:09 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <3b746802bcc4b08e9a6d2f2fb2f7622197a2d25a.1781911900.git.tanggeliang@kylinos.cn>
References:
 <3b746802bcc4b08e9a6d2f2fb2f7622197a2d25a.1781911900.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: fix const qualifier
 warnings in strchr usage
Message-ID: <f1e84106-8647-c483-7237-0993c39605ab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 00:30:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/278536=
96726

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5b68cf5259c8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1114094


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
