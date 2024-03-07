Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182181F
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709795055; cv=none; b=VXWhBBWTYcqvMGJlMbLIJzawPuaoP+gLa7y0/20nzTsw6OtHdwZQRALe7Gpu5evoBZhj5TlXBurEcy/yl8p6JB28mt75jyngV2rMyieYPfiFFckXs2bYflbvlcMc11i23ArWMk7bV33fhPnpr5wPoZDqcAjbohsDa+bg+0/qYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709795055; c=relaxed/simple;
	bh=T9iYpfYAMXHGoSEqeGINTpRLiXhb7WO1FeI8tW5zw28=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=W0N29gvi4Ktuiz0PDLYlCsmgIrUB+gjLFoa1xpGXl30zy0QHv2eoj23hn4qAgcCT6/6vrOwmYyEnwVDIUlB25uZycTwNL1JJqm7IWjHTxQdlIAcfUfkDzuAx8f8/gussQ7ZcTO2Mc5+7nCWOCNzAmYxJpur+NEwCd+jy7ADQE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTXDZu8R; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTXDZu8R"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dc8b280155so443260a34.0
        for <mptcp@lists.linux.dev>; Wed, 06 Mar 2024 23:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709795053; x=1710399853; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXbb8uSlF70v4N1AMpf/veosnq8GH7G3SYZOZtAz3EI=;
        b=eTXDZu8RadxBzIaEkNjI6wBI1NGV+05Zw853dp+gbKaEPXlszLnOKZAykOebgu0urX
         7X3mlyQZ/KovOc6x9jcMRiTXKUV+ZiyKu+E11WqaJrolMXHMFGl8zW8RARNTT3rVddKt
         IGWc3HcSkYuMOU7ESQ//mZccsyoqInZFwTWLUP5GmpuO4zK2OVlWJOLbnGG95UJHIdV2
         EfFpN8oEzQd6czkZIsvzwbUrpdaBQHVi1/d5NraDMdxGsLWl4ZaX+r1P+cN4evoE8+O2
         Ra9hiw0EN5K7kWF/vHlI4IzBNcLm8ErJp4HLuYNlMQKTEE5Iuri6VBPsSuvVuDhjCvTu
         I2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709795053; x=1710399853;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tXbb8uSlF70v4N1AMpf/veosnq8GH7G3SYZOZtAz3EI=;
        b=rHEHWNM+6Hz8bT9YSlsVrPR+c/KZQLOlkS3Us9en0ga05PkUQfLtpgjY6zT5ax3dkn
         BmWMxQsE7co7RN0xFnh+XrV8AXz3zGj8xLTTBtVpK6ul/5JKZc7YD67gffW/50+/Hg+B
         70kH/jAACP6ni34/jYSx9YeW/pBQMGwuDGtmR5pwTra+lR7DfqaprpdAhNs/lMEbfvSM
         yi4YkrQUS7ru4+6GOfmVZZe1qsHVkCuxyj9ZbxCMHuqVp42TAU7iqg7EBc4CRI1fSzHF
         Y6H2qOUDqkaH7+C3P3W4GL2567b82FwplioAvHXmHxr2Rppj3qnvOXMYyQVfInyU3GxN
         PL/A==
X-Gm-Message-State: AOJu0YzbuRbI+rnhTAyoFzZTYZHagTul7muNnqVPjnm6JZ3EzJttDzZY
	pwbGkEiAG7IZcEPJhWQ2ZKJeiEAVb9OHTSQe1Vq8J3fDYaOTuo5yyPMNf20=
X-Google-Smtp-Source: AGHT+IFjGsVtSZOORyXNnMkzpQLZJc3ynZYP06AyaY3biqXY75vC11PhupnPDVpTaa+uzWILW9zGiQ==
X-Received: by 2002:a05:6830:c5:b0:6e4:fa0d:11a with SMTP id x5-20020a05683000c500b006e4fa0d011amr7651143oto.12.1709795053081;
        Wed, 06 Mar 2024 23:04:13 -0800 (PST)
Received: from [127.0.0.1] ([20.172.43.104])
        by smtp.gmail.com with ESMTPSA id c11-20020a63da0b000000b005bd980cca56sm11955559pgh.29.2024.03.06.23.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 23:04:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6f47bafed58fcc6fd3236b12134b23ff012d5643.1709791100.git.tanggeliang@kylinos.cn>
References:
 <6f47bafed58fcc6fd3236b12134b23ff012d5643.1709791100.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_print_test_results_with_colors=22=3A_Te?=
 =?UTF-8?Q?sts_Results?=
Message-ID: <832fa2c4-ff7f-44ae-324c-ab8852b0e0bc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 07:04:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/5071392522108928
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5071392522108928/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6197292428951552
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6197292428951552/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b5adaaf15cb4


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
