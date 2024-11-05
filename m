Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA401C07D9
	for <mptcp@lists.linux.dev>; Tue,  5 Nov 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805946; cv=none; b=BEt1UoiZsXlcNKC3y1HyLMc3/oppqHy2vvWdnzOsg10fkp2LZ6cKOzUXNa5yr/GwygrUG9rLrdKUqtvdlqBxk59d2IIU7BG4UO29eMZgvbSDnf48xPKpfCjUKpi0x4zj0rDGWRdiIcDC69XTqIwYf2zjTl/1t3WmZYDV2GAQyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805946; c=relaxed/simple;
	bh=j1fiqgusdf6NnIg3VYGnHwDbU3A4ASTB5rz+NRZ2mWY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=QbTY+1aj5l92JVU6ohlO+BEJZVtsL1x7/V4+27vmTEJi6yl6HkK8xz1ooPYAJDaPd1BiZD5M5s8QMAFlx7RJHoUKZrtcEWPiwXR4o56KKxgmNnOdNxpYoJ00eCAXYMzDRpcXIK4+mz5s4eSqvqSioGHbVYHxVhfLkyHoNLNoXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iiha/g6n; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iiha/g6n"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b152a923a3so371672285a.3
        for <mptcp@lists.linux.dev>; Tue, 05 Nov 2024 03:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730805943; x=1731410743; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQW3bfVP1qBgXr+aBrTXHMBtKmMoQND/APysoSDJ2hc=;
        b=Iiha/g6nAWWFTL2kpiicKFKGOOYNfuD6V7e6HH5dIlBXXjTw7PS20uYDO4qgLUn66D
         /45TSpvdqhKOBzBMwlIfwGLoZwByu9IaL83gajnFKMzN3G3JZ8fcldB27e2w0tUYfWcv
         A8sTn4lfve4jSheFtvFO9FohLxEoljIDKDruEPIZ0KGwTBsTEh5rwtQ8CjYHPj9k6nJb
         PQD8cdSqUIFcqWXMOLw4zHfGT0I4YRvSorAq1xQguEBZ4Z6wkZEKzatPLLw+qBJKMfhE
         OZ0QgzYfzvizi3XvOeK1Oso8d0+esS5CPr2U/8ogAXeAp5vfSsi6aIV1UsPafOn6cCSP
         tigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805943; x=1731410743;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQW3bfVP1qBgXr+aBrTXHMBtKmMoQND/APysoSDJ2hc=;
        b=tjkxXgbY8p2uftkLh+daLNeISorzRzYN2jR/qKPipxhH6gCbj2bFs97DcS1+i1Sncn
         VZoOBHKsRT1LT5fhg/oJLjsKD4IGXyMQDIE+m+30LYdUX3J0ahJdiWjCrcGaBqh4cE22
         sJIJuXaPzhRKiB12J7veMdrdlmQd+SWD4UW0QhejHhMVwfEEAD9oViTt50F7EtsSz5Kt
         MhVbLlUyI9Yld9tEsplSF5UDsdvkR4TXZqfjgO0kjdziGCMVerKfNuJCaSB6y8udaRbj
         IoCLNzJXRZ5gLDBHPOSYbZiHSjbeMxexUxWIg+0NtZljE6c0UAo6wu3WKkASA4R49KKQ
         gKLg==
X-Gm-Message-State: AOJu0YwCv3SU5mLbnFmxSWVXaen7AvkZqm+wCl+d35X+L28xJE9E2uM1
	gEs7m22f/okzmfCQfRMrtEJ4jtM53scp98efCbyt6hIaYsysdB4Jng9C
X-Google-Smtp-Source: AGHT+IHurmRzlpenZsu48l+Cy/S+e3dcKvjQcSEs9Erz8xXpfaslfWHdnaJCJUv4mLo2Sc6rV1SwBg==
X-Received: by 2002:a05:620a:284a:b0:7ac:abb0:2317 with SMTP id af79cd13be357-7b2f24ef3eemr2727704185a.37.1730805943295;
        Tue, 05 Nov 2024 03:25:43 -0800 (PST)
Received: from [127.0.0.1] ([172.183.53.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f39ec671sm511253685a.27.2024.11.05.03.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:25:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1730799589.git.tanggeliang@kylinos.cn>
References: <cover.1730799589.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 0/3] fixes for userspace pm
Message-ID: <71382ffc-083f-e18e-bd47-c58fd424cd72@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Nov 2024 11:25:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/11681780257

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e594c42ba8aa
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D906422


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
