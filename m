Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559537D07D
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743458027; cv=none; b=AxrYbJ34M0h8Ws6uZnkxZ+WRB4ycYa4ERezrYJeYnau+v+Cn+EUkOg5Qt/RnjuvHufKHlHVh97b2D6lzKKFrhjDYUpSEBKtF8vi2VP45x0ua1RKavGDQ7TReGhvXRHXQRtLnYS9XER2+W+POq82guwZktjv9s2P+yZcqYK3Ovwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743458027; c=relaxed/simple;
	bh=L7ghD075z2YIYRdUpFK/CFsOBY1Cz5wIw7h8oARIhXo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=F1ISKsYjfHGIOiTFFOJV/gnqaTw6y2Q4gw7Np7krqB7OXaAYfaRZL3MjnW8pmn00uAYT1flcu1DJt3V4xW4Jv+LkMhTaleMYnbr0sUGWxa/O7dBmj4ce/Ge26sXwqUzTHm0diPJXXwsmESZwBoJ6KjBOKY74cnZVpNd1JCRKM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkOWFPVX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkOWFPVX"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be49f6b331so497709285a.1
        for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743458025; x=1744062825; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXNv7O6QJdLGou2KVKQm63sbPVU1HdPSxfF8yHxg2kk=;
        b=WkOWFPVX5q5Tg8nUyuI5mRDzaD/KONj2D8BBFIYkAn2UlfYLR3uphGTG4tRDyCanXz
         xXoKj7CdGHBYpcDuqN6sBJUC7Vg7ngEr7yQQZEh+lWb+V9lGRC5fIzm0RhreiGHH0Z7o
         A3UtDlnyuOJGJbsFO4Np3CX9WWGPf/3mBHaDtAnU/cAXCte9hiO2cPG/PwRBz1K+ZCBd
         tkMmhPoa6oo5pCaue9fQiuJNW6IUzeDyEDqP7PkedeZwnvu3LhaGGghMA9vO1fHrjpPo
         rTVn3hIMA6ue1hw2U7PGIqzm060T58PqUguNT4wX3u7G6wDIhyckYj2FT/judzz9/XJ8
         NXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743458025; x=1744062825;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CXNv7O6QJdLGou2KVKQm63sbPVU1HdPSxfF8yHxg2kk=;
        b=BoE8nKj/sVpDJH0qghdtBhkYzHVS8JPQH9VQdjhhtnk2v8dsOK7/ON09YkbbZKq6ex
         Z2K2HYPPRiu+RlLQkVB2zi4BGvVfGSJ5jeE8AeACAR7Aam41l/WqJks33W/WDgujpUjd
         lZxM/r02XrDj3M1iGYoKyMEmBMs+ZIqTr4nbDj/+LEZuEOwq4XYvGD6c8uSxjIoN9qod
         oox3/XrJnzLlii1gxBDTV9LVUvCDzs3WeV3vHU3JvKHaiAXqaLK6sNDTWeBU2uJNaaCP
         b3WDVLtxWFUcqwG9BT5tbs/tcTXcVUXU7g4HdExW0X92aRavp+zO2+WkuAun/cgpz8SJ
         Tw9Q==
X-Gm-Message-State: AOJu0YzqVEO8pk/0MxalIAMDiswXzVvLMIEvLnXISsk+byto5A9Htibz
	IPkimTjC+8qyrVk5SD4SiKq6Saj2YiurGY1Xmvx7VQOD8ro9JQ9b2BAW
X-Gm-Gg: ASbGncv1Qzy9X37BNHe5Bq/QWuvWIM0+5xDeJS1UWX8dSE4Z6QZbdp3S69dqs7S6P+W
	XaDM6CPv22pcQUcmpTgxtSXB6OGHrtn3vgM+faRlO/Aw1Q+N9mMXdSVqRLw9Gb2ug3hXjfR2GTJ
	X5zA+zh4/aAJ6Nu4km/TQhn7Zysw+3+4Ia2aoY49GW1wQyRtzLboljIemxUIGL75rplQoPSM8Hp
	ZzxgOa1zVXa+zrp7d6ZHptSj0xoz7sUI6VQSkYSRxPIHnpgJh4YhT74cApQsFMRYcZD6vOXZ1be
	mFe2rCi0tLkzlc6Pmsc+6jxfrNpQXUMFZLSKZ0asA4+zT55GXCkkOuafRhE=
X-Google-Smtp-Source: AGHT+IEHGPP7mRIcE/l022KBMYiDRZGr4pdp/Tzeutzpt5QD7Ux0gl263ZiY4OpTBVcRQQvQNO3Mqw==
X-Received: by 2002:a05:620a:2995:b0:7c5:4788:a160 with SMTP id af79cd13be357-7c69087dcecmr1433477885a.44.1743458024960;
        Mon, 31 Mar 2025 14:53:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.229.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7684febsm549278585a.45.2025.03.31.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:53:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1743449872.git.metze@samba.org>
References: <cover.1743449872.git.metze@samba.org>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via
 optlen_t to proto[_ops].getsockopt()
Message-ID: <263a9fb7-d230-d10d-9830-b79b5d8ea5b7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Mar 2025 21:53:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Stefan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp =
=F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/14180807770

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e5554f1e2602
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D948670


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
