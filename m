Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559951759F
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902973; cv=none; b=Iw8n2iXx1sAc7x4JMBuwPRe5eN0DcQ4JApf2jBpC4zG2uL7WChxvaS0xF5UlEX4t/MYyk2RcrfnwP5NiA/e1bd0zNp3ppqWDDGU96VWVMOixv6fKFdPX+CR6Dv7pqkRe7Es5PWG2x+9BRruOczGrd3AFh5cRvMvwa0e6WocrDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902973; c=relaxed/simple;
	bh=e4UPnfZBpxPRzNSaNL3wQv5dQgRjPen4bWK2xDdysKg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dntbFT5Jt0oUBWtNdZpUaMjhdrvBFv0qGLYMiL7fcDgizoUOIqFUgzPW9WG/QOJ4HeNcpneBiw69m8tgccgOLcxCSuTk20GRNPDrS1T3SJT+0XHOUXBCnkWPOvK4lpq11BPa2r/2OG4tt8/FlDZSrj+wHrfeHPfQLkujMYui8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YENfBlde; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YENfBlde"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6818a9fe380so31589056d6.2
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 01:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707902970; x=1708507770; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c3SpCv4mBtgYl54+lZNfcyhWjY7X2V5oF1nq99hHdw=;
        b=YENfBlde+koGfNEb9GgN0nOc6LUm9B/wLd8FGMHjIExQ2XMKDWCV75CI4zoplrPl0t
         9+/Iu4I//95lNkYY+hHqSA0nOFbj5h4Kue7da+PLL3hEowGZjIn/YN0tqFyxAy7sfiec
         rcWQO0VK2MNnC5Utuxe3XJ/ckjAzmro/1dZAquF3hk8bJ0i9qT+r7J3Sb6FLL8NaudED
         1TIMaYLTzX7UB15gNeqONnjPJ5qCJY/+3gMYDttMEdiaPuerKV+zbEKMmmIH4sJD3QKW
         WfEVAqJB+fVnr4fvqLO8qzV25wi9bapqVlPukd2N9raAQNNKhtsxUB1eZhfdAObCVtqt
         SRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902970; x=1708507770;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8c3SpCv4mBtgYl54+lZNfcyhWjY7X2V5oF1nq99hHdw=;
        b=Xb5/cJjMRfWDp87fa8HYVxkS+inXJzEKu2xAjvbCVp2P0jq1qyXwMdxaOhTTTIzcRw
         ZeHXrTxeCxbuI7Aut6TVdGpfjONugFhJY48hr1MYq4hNelG/9UCZepU0mt4QjZfaTvjp
         deuZd/rKDvUtphbczRnSietCzyoJ0kopHZsOqpBokdzB7vGmNuBuwvEZN6uNIoVUW+34
         iHbZYhXlu82soI4UvcHHDy3h5qKWClmg8c0n5BfaHalcIDZqdOIlgasYffI4TwPViAAs
         cB0jf6NgS7TiIFi30wSqwAms4Lzs2LSPvw7KL/Ivk8FzpmdjhIHTtXwBcLejjJ0yY7H7
         cGXw==
X-Gm-Message-State: AOJu0Yw1oaj9SbnkW9JeA3SIMkw5+nZxaw3JM/kizzw8Chlka+Dkdwz2
	JXbz3o/XSBGsK09hAvnD/BxTCHhk9wu26XPMpxP4tK5Fhb0Oma4=
X-Google-Smtp-Source: AGHT+IG2GWD+wTnXZ2oa++QcmV4QovenuLVtkpe879fhkghPZUL7xDEx6HQdJwHAcgFq9GiHXwIl/Q==
X-Received: by 2002:a05:6214:c43:b0:68c:8037:90f5 with SMTP id r3-20020a0562140c4300b0068c803790f5mr2171716qvj.44.1707902970708;
        Wed, 14 Feb 2024 01:29:30 -0800 (PST)
Received: from [127.0.0.1] ([74.249.21.240])
        by smtp.gmail.com with ESMTPSA id lb7-20020a056214318700b0068c88a31f1bsm544662qvb.89.2024.02.14.01.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:29:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240213223135.85957-1-kuniyu@amazon.com>
References: <20240213223135.85957-1-kuniyu@amazon.com>
Subject: Re: net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.: Tests
 Results
Message-ID: <fe0f7972-653f-5a65-e06b-c4ee1097d376@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 09:29:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4629533685448704
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4629533685448704/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5755433592291328
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5755433592291328/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fbdc306e8139


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
