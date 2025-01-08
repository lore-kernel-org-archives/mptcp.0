Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8E3FBB3
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736306709; cv=none; b=XWQ8t86UhCM8XI3RDa2O1/Xw9gr3cjS19gR1a8zVI1q/prM/9bFXEEEHQJMZ5FdVnTRT05CdM2MotKDV9zzNcAlBEuADBEn3Tf9295ajcVYr9zijSes+bfd9IgGACN3GoLvadHGvSN5Xd/QAdMhzAUqiUTgljIcxHQS4W4r5+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736306709; c=relaxed/simple;
	bh=M9DDlT5UKn5qe+8llEgVXm9G9aLmByXOTuyfRuiJDBs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RBbQP4f1oSCTXmlwBzesWPRKzc5gl0SUIyn9NrEIykCj7MOCZagRWMC8JKPKfv/Qa4n7Feqs39trq/pvEzAYqMLufeLWdyrtSYAJdPHhS5lk4klupTSn1Akpiyrg7HmiFbWTWxeiRrtJlZGVz2AVkUV5p8uqWhDKH2YWU2d+5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGy0JlVn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGy0JlVn"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6f1be1daeso1511072585a.0
        for <mptcp@lists.linux.dev>; Tue, 07 Jan 2025 19:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736306705; x=1736911505; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2PJZ+BUGJd91q40j3i9QJeYNwOuqmWV+SKmI9nW7IA=;
        b=mGy0JlVnVn8+EIy7SyblNZJ2Yx8ET7bvE/ZgGmeWcejrDiZ6usOfKZKuiZnOsJaqS0
         D5VHtIxK3oCexvlzRJ3Vqn0as2gP9Urypt9H+xa6AqdCG1badYqzgQFGveEla85voiHp
         /bVfMnisbO5jfyhg2SX7Gq8qLYkGCOHvX2GS++cMLP5CdyLBdq/nLW3zQPwfBBsVLfH9
         NEq/1B6BWdC78T05AbQuI8IeDaa/LE4aGi11YhIljwv6jgqEMefKGmzXeNw9X3FEk3WH
         6cPc5KHt7KVi4RMnl1sI7JT0YAlc2vStaKU8y2GBJFtoCEzHS8Ol34NrlaeB1c3TMTQO
         DS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736306705; x=1736911505;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2PJZ+BUGJd91q40j3i9QJeYNwOuqmWV+SKmI9nW7IA=;
        b=K6tG69LZW54IdmpRUwQ5uhksw8VrzO/WXiFY+PzRAufmIqjv/X9vH46rKYx5Of6dMA
         RBluYnwvElrrnKXOBKKE6SWDQRTDSfLvyxlFI4FQDW+YpAXfELf4duX9EzCKiFmaFDVC
         b6UKpbEpdpkDgH/guw/rhuMQQilK+OROoqUUpD9YxpnE1h5l8vyzmwDihsgXetogrfIL
         IasYAKA07XDeP4a6OtGnC1se5VI2bRQqLcXiMRBHv4ji3SS9F7LUOD5JrUTt+DGbmrja
         Slv/nL7T7NKiqXzscQRJ3KYgFC09cDHSXKnYv2FAmii95BFCKfyLulh+xvvrZBf0js6I
         zwzg==
X-Gm-Message-State: AOJu0YzmRI5+l73Ioohu915Psk4fpBvqec+25kMCsbAzU3A3YJJGZMCx
	dvNHGg10UR6EjcIaE5ee0jfvBhW0ImtbQIKqFP8bGBQwVoqTi1yTO/uA
X-Gm-Gg: ASbGnctCmDsVx1GTcKURR0L7K5c4L5ofE57rdyaZRf9cpTywZbXF6eeGcq5VTwSTJrJ
	J5Tjw0ni/zr8RgSJz6knTvnBi7PE+7m5fSdc4inU+U+3xmkPuq4+Pwe//RNRcymZpsTIOXveAZc
	i9Ko7lUJr8lL+R8t/gGoZykF+kn+SjpQ2870B1yA6huT6YRDDtIb6if6vUtevhu8LKQ9DqkySF1
	X2WhQpRHWsaK03uBNdaeguLIrMJYgXr6+Wc9TMxZ54Ujg74XwDevp+8CMPR7hEHjSIgTg==
X-Google-Smtp-Source: AGHT+IGZTtjnmUARDMjn1cWWP1QF27LU4FUoC1Ka7kOVxYw6YugNIUxYAqvZVwndER8YU77IqeozOQ==
X-Received: by 2002:a05:620a:2588:b0:7b6:d70a:86df with SMTP id af79cd13be357-7bcd9715898mr183303785a.27.1736306705628;
        Tue, 07 Jan 2025 19:25:05 -0800 (PST)
Received: from [127.0.0.1] ([20.55.214.160])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2d15cfsm1645044585a.34.2025.01.07.19.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:25:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736299989.git.tanggeliang@kylinos.cn>
References: <cover.1736299989.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/8] mptcp: use GENL_REQ_ATTR_CHECK in
 userspace pm
Message-ID: <cc7668c9-d8f1-95b6-10f0-332daef3afd0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jan 2025 03:25:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/12662643252

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/f845d68f8495
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D923191


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
