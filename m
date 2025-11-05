Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADF32D0F7
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353282; cv=none; b=rJPfiKNsBylPtVL5zyBNtuiMhBrLb5ETKo59BIO+35wBUjuKs+QV13xDYu++62EH0Val1ZranNtbJTk7/ap3oYqCO309zfkJdF3SxI5D3SIEotonEniwc7YnyRJyb+2zCCHtGuTnUz7eqEsB+dYeEnQu1EKpahnprhYhuCbIkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353282; c=relaxed/simple;
	bh=fhh7xKZrSQ43pQbou97HX7WEJs1XgJGPAaqOrrQzceY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=m3UoOMnyYxMgoLJdbqYhYQ0sJKVE9lqActrVmrkoPsun9hFSsp27RK4S/GtGDpT7je7UlO1P8cpdTA5hGiCTBbZGk+eTu3Dkkt2w11CauYy50mII/YJRx8NWbzoMlY5yYPgcQA/ML0Tnu5NphPt/bNUtQM08KmJav+mNnE00UXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWXWj6Wq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWXWj6Wq"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85a4ceb4c3dso668164885a.3
        for <mptcp@lists.linux.dev>; Wed, 05 Nov 2025 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762353280; x=1762958080; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT8BCOKErAtq/7kZEZ8CZ4mOQSjwSWvQceCldS0/Jak=;
        b=NWXWj6WqyxJhp6f5cW7HLA0BaDHeeBziIi0HBvxQlvhqzfGAIghy7LkD74+GkJV/5I
         DNUKz0ToPw2ALwAwEWakFupeRYhbU+wsIRJeAuKEL8V8t0VbQ49s+DaLm0AZ/tx6sAhk
         EhH85X8yyrbsj2id1al4yX3NtqKFzEcJOWqP/+m6pgMP5E83/jPseTdkgd91+QjPOwlM
         qgqRd/v27r7MsQKKHfUYaOb3ge+yTYwL/9D8sTsChOm0LModGKugWVU/a1EqRKGgtXbc
         x5TXHU8lfH+F1ob5GsT4pNcfpyfn6Kw94YiJveixJulasRPIeAbjcRWn0tnw6xEOJ8u0
         l2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353280; x=1762958080;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YT8BCOKErAtq/7kZEZ8CZ4mOQSjwSWvQceCldS0/Jak=;
        b=srmBK5l/Fwu7joJyLIgLxmUUvQ3QNJlAAGZfzeF619KLF9R+LDj12PLhjQts5uYW8T
         wG4hur7otpu2dUQCOADCvaU3d947PC0pRBWxnwb05vPMX2HK+Od1jzcZDzZEcRuk2EEf
         XMUVgQ+js4KSBBiqzRKIdlGil/7Riqa5PYqYfj14Fnt+f/DN4j8x+RpEAeJc0gMTKnEK
         oHRiELUadJxHAI6P9JN+ISlXSXC8P8jjnP/ATgyWw7WLeFANvsbVXBSAJIA1yjz+8G3Y
         /rzwtHS4rXQtiijmAxbIe0rhXI2Lgc/8hwFyEWiKJiP4HKcx3298gfgJtm616mAC00EA
         jOHA==
X-Gm-Message-State: AOJu0YxoadVqLeYDNwz35TvYobD12LpIMNfPtM1VLB5CpyUiUuxG5juS
	X+ikJRvOVFjzA/l8sDCFRHVFp7tlFCvvyZjNXq8HzxoB1UdC50uQ8ug=
X-Gm-Gg: ASbGnctG5o/KWwrrJnE2ph162JSr1ghUqVXcd9OH3LBK9u/3N1/67BoTnyRzMXywzC9
	/Xtrf/HldVzWOrbtZ51aTQ7MgfCMyEuZDRLhYRHf7gQ2dnW0hgXNJ6xpt4AIlf2wpsE+DwGd0EQ
	WgxaY3cFCrTkUZP9neyi1ZQDKh+Xbqje6nNJGITwwxR1cP980IRxuqeLzh+k7N0+pprRnSXXq7U
	hCkxvRROzsTuvdmDlZWMVlPSwx/y/yW2hghpt6MiRPbYIiu6G/H/Q/U5d08wzQN05BF1Sh0RJMN
	jRbYwoL8Nc6cuNBmo1cnr96UZfkKqWE1mdskB6YA3ydjrYIFBsMSogvFUVypDgtJda7Ao9pzna4
	n/fsvSo3G3N0CRn89cbga5NwAMUXhNKlG+jWeVn31ho4Aty5ZSV6UAJDTm2QcGl6kE6d3dvaVq+
	D544G1RJAn4p4=
X-Google-Smtp-Source: AGHT+IFXuoPFmBz0cUiqXxEN3J9IVR2NQ/hmXvsrMjFSkIq8Wj9PyBpVwFCewXk33/naFAH5GgxpWA==
X-Received: by 2002:a05:620a:855:b0:8b2:2607:83be with SMTP id af79cd13be357-8b2260787f8mr162054885a.12.1762353279996;
        Wed, 05 Nov 2025 06:34:39 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f76cde2dsm416903785a.32.2025.11.05.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:34:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251105113625.148900-1-jiayuan.chen@linux.dev>
References: <20251105113625.148900-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v4 0/3] mptcp: Fix conflicts between MPTCP and
 sockmap
Message-ID: <aa067cd3-40f5-d6d4-0fe7-803143eb5b99@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 14:34:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jiayuan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/191037=
62226

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bd1999ff8048
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1019848


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
