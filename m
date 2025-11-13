Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9EF322768
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763037204; cv=none; b=YMg2Q4/J5Lxs7VRRKjlRxgNea7xwLrNaZwW5pt6HZyojDGgWZQ9I6HZLpl6TcPwJSvanmZKdTIAApeTsAnBtOW/0Ppfe6uo/RMY1w/DyQbiyLfF6rhAgBXio1KYg5DrHzdxLlf54wOhm9jxR6qRmlEeIhPc/QD3Du/f6ObOz+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763037204; c=relaxed/simple;
	bh=c1yD8zfcGai8VQpJxml7X22nMf+txl73aiIKgeDlYWE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=V7ZoakhbSfE3yhl3GsTVwTfzgQelR9+E0Ez/e7dCDEi2VqgAHMkXdRVxAsAANqHb0RQyQ9/bD7mYOGCG792Mq52niWdFC57xSU/JbGqJtcmbFUEmMBDzxz0TNImokQsmpH2/P2a9JNt9cpjKL6jaAvB87sJtPh4Q7/VxKxyrySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaW9Bktl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaW9Bktl"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so741465b3a.1
        for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 04:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763037202; x=1763642002; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgQu5moplDRk2MxDAph1/WFV8JJxPZdXuODWhL1RnNM=;
        b=aaW9Bktl/IFPS0q2JPzORPa0gNJl/o5fbJaTOOf+raHtojyvDiJdJJ+MQojE/Zw4MT
         nKfLtpDFrlkEBV4bWK3P0fUT1TjHLZwl3yxq9T5s4iJCg2+Yt6lXIR1EFp2yaaZ7E1Si
         Qo3ZOYZNx52eDETBxkkLpUJ5jWp3YNEveeVe7jYOfyyZUGZKs+rma2QBrCq6/nTLcEVa
         VEPb4Paq09eOU1gfpNSuBy6XUSvgUAoQLTNsZUT65JqEhA2m/QTTYQWZaq5yCGmSOsB/
         pCO0QLed/Nkt+5rrOE3E8ukl497eePeLCjmPfjbWSV/JCjGdPeHDGmpaQxdiZMcMvJ9e
         eQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037202; x=1763642002;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgQu5moplDRk2MxDAph1/WFV8JJxPZdXuODWhL1RnNM=;
        b=Tn6m/Pd23CE4OgCIaEFsKy7jw9OXoN4teelTb8RqAxqneK0yvbNAVohJvHze+HPEpO
         Ksx3jCBoLqVn0b2W0W1xyqk2QGjMdXPxmNjE0z436kvueB2OBStv/2L2LcKIgBPlO+83
         M0Ea0HiEIFHr/Xyetvpug0mDg2JgKdqCFzhYzwUXH0jnrUo3C0NUyy5yBfToSVE/wRPP
         DcN8wSEuwvWv1xUfxblarXpd3HBmRe7Y71pXJf4Bq5x1FqrH9MA/rDaegUZy7MR9MBDB
         kPY2HAFNQlK8S0d0LFg4nPqlX323S+nsKPZWvW1Q0RizIfzQVPqNeFBOjYk2cElBd78L
         C4aA==
X-Gm-Message-State: AOJu0Yw1qiNLfXTos+jiQ1gXzyTKFpjGq7Jzt5rvJCZV0Siz2I3s0H+A
	A7nBBRwzjGwXAUhazUd4EUwjAIKUoZDWILXvNAq/KiBlJwFxmTcyW7v9gWzW
X-Gm-Gg: ASbGncsQWatS/ngxwDcUHcn46hiMedFF433k7fFXP/cBgcHUhquFavvvR3B0rrsk63b
	3zXj681l1HYA06cN2NGiJ5NnIEd1ZRRJYEEXRNUWXO0UTo3ZcPKuVtdI+ppmG+1n4g2kNRgfZpv
	S8DvC17BzX1W/e0cVpbSPbytvNbzhnqa6Oc6ApEC8EvYhYLVFND1l2nEiArPhswN17bh7oa9foQ
	Jy2buDGccXmCykWL15dZxyhLzvRSkNKlbYxl9bI1xxG3fEp5BMP9cWiDmyBF2ELxxDTgM/Eb9Yz
	bOSqcqAZD+boXVwhGWkaYQ+aJi6DbghBSFTHyHmGD6V4CrT/jAUA0FGIZlbFI9peE4ScJJulrI1
	8DH99ebdvQCp6ie7UnqoFK2l8HxWPCv1RtdRWcIleHchA8+oVIM3CKMKVEGRcH8ioB6AWTS3NqL
	a3J+q7CLkV08DC
X-Google-Smtp-Source: AGHT+IErTX/qoGgj2KS9g43DPA24wy2DLiNs2iTpiemzqJP5SMrV9o4TXjqC0NaEZg1XfWCxXiUdyg==
X-Received: by 2002:a05:6a20:1611:b0:342:aa43:7f40 with SMTP id adf61e73a8af0-35908c8d21bmr9126302637.1.1763037201857;
        Thu, 13 Nov 2025 04:33:21 -0800 (PST)
Received: from [127.0.0.1] ([20.169.72.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37507fc7bsm2117495a12.23.2025.11.13.04.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 04:33:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20251113-slft-timeout-stats-kill-v1-1-9a09d8f46392@kernel.org>
References: <20251113-slft-timeout-stats-kill-v1-1-9a09d8f46392@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_get_stats_just_?=
 =?UTF-8?Q?before_timing_out=22?=
Message-ID: <a4b6b565-8214-7ef1-c675-c9ef9f9a4260@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Nov 2025 12:33:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/193300=
80819

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9a2c02054a5b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1022917


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
