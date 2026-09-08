Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B0568FCD
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890032; cv=none; b=c1BAGaB6wVSWkxlxd4FeTgkieI4ZC59vVU4teUa7L7pUg5LmYH5DSFv9md6VEl7Rd3mBDZtgwVUMp0WWMkcnmXWXq0cJyOT1op7EVbOVYnCbrgBAj6bm9tiXWMC+MBwoTqI4iRlBM/3lA0EnT33Ua4/kdnRUlt7TqfFt6vZeDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890032; c=relaxed/simple;
	bh=7mGZB0/gnMjXXjEBNRwXKwsyvR67IBZT2ijSetAkzVk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=M5yaSEDn8gir5d8gQdSXtJgw5KcE4mUniLlzaKcPLVij6mynI8h4T1c+U2o6fP+smJJpZnawTsWEdsbs6kZAoN3W7P07zodfVjOhMeGZlhRwJLpHAWOCQnekSqlBQFcmbsKOgVb3P9Hz5QSBf+tG7g7BvqM2nF59sNIVCV44EGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt3L9Lcg; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt3L9Lcg"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53031a57d7fso50580271cf.0
        for <mptcp@lists.linux.dev>; Tue, 08 Sep 2026 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788890029; x=1789494829; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x41Ug1A3jXBpX45mFV1kGuFt4Q6rl9iTG3aM5mGLzes=;
        b=Lt3L9LcgNmMN7NJW2YADk3AQQaGewM6BYrt8Z15hi1Uq0SOODNBR9JMJBkMctASwWk
         UI+f+m4ru9tPvne/5146NTOsAqd2HVIIXK+dj5iYrUeltuu8wI9K8OWIwsdSj82RjhuZ
         CvdzE/P8wtmgByunteQPhmE5oZxMYkkQr3kVWIXibDmy6yg7PtVDRkOa0/f71DEE2Zj0
         74mxIYUonJVxqNP+Jg9V8F/wpMkuCXJLyVh3gsWFVGPFZrjCHwRxYtqnc/iu8l5lCNQ7
         E30jzm89a7uFqsT3LB412CdyEIhHmeL7URtFb6xfRIUWb/32ivXx2kjMLIMxYuun0wGj
         CLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890029; x=1789494829;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x41Ug1A3jXBpX45mFV1kGuFt4Q6rl9iTG3aM5mGLzes=;
        b=FhD83f14xazMcqh6jafr+J91cd4f4qs3XQW2pKGbY9SHybagDwc1yxVmU58wX6HUxR
         Qwv6WPkapzQgo1wtmFZ7i7t8fGWJJNBO3QhDE436BCEjDsfQnohsQXzntBad/PIaympW
         f7G+csHiJSmZyK2YGbXAIDByXLK+RPUABlenkQaQ3So1+vbpBxx1ff9bujNaQO5P4QpM
         iV5jccugW59zVfygFes7XBN8f3TWpxZywVtdkXG8rPOAnqRogRVMJ/wrA0vQF93nOvpX
         t9XnaFhfe/DVL4sBfq1l2/nIdIC9wfPvOHYXb6zsZMDffMzFSiBxC75+tL678pvUVhc2
         Z/CQ==
X-Gm-Message-State: AFuF++ndErVZ+RjEBKH2zZyOQhSP6C8xQSNnkKOj6TifgQ8Yyw9tdC3f
	JPDzdEGse5LRyhOPJWv4PsYe+4/UsKoPXZ2d4W4Yn2DqBgH+HtbtiOI=
X-Gm-Gg: AYBFou3cyoli3AhqzagNdIC1lJfc8e9lidhcUwHJAq4EW/eQOCHVrkv2xbGFsTZc4vF
	yuNgiOYhnAwj87AGM2fbKC9BpckhsImvh6ODdQZDE1eEyz3DvOYmp/zYMIjHo5ngAAsb7otvBgf
	dA0asQXp22HfTZXKfN6rZpda1iVDtzdi+3IhhLxl+aDEwM8lSTNKwIrUTD0GLc4FMDhmt9RWFsn
	svPe5+91asTeasI0Xhly+AUVVobYlW91rBECsDasj1EaR2aoNIV6mvui+NYSFbG8i0NHNmKztiV
	adNuVxbwEFIThetllpnRkfYL9hVl3vDSot3KSFrTfzs5qioeh7aSA0ehyL2uZiBQ5b7BOHwY9vw
	LRwAYx7s+JjdXyrshIPEY1v+/j/lL+SCpubKO21n1X37nJOX8kED02q5k3ynN/138OYaoLstxOe
	jdWPMB6MaiFrknTaLUFDd9W9lVjYNfM8q6fbHYP3nsYRKceOOWn+3+pLGtGF9Bzf0fFM2ktaAAW
	Kg=
X-Received: by 2002:a05:622a:418c:b0:52d:bec2:c34d with SMTP id d75a77b69052e-530549600c6mr376605101cf.25.1788890029277;
        Tue, 08 Sep 2026 10:53:49 -0700 (PDT)
Received: from [127.0.0.1] ([52.224.244.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53093295584sm30352931cf.13.2026.09.08.10.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:53:48 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ruide Cao <caoruide123@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1788800732.git.caoruide123@gmail.com>
References: <cover.1788800732.git.caoruide123@gmail.com>
Subject: Re: [PATCH net v6 0/2] mptcp: fix request migration ownership
Message-ID: <6cb7409a-4be0-6d9a-8206-ae38f5f9eff2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 17:53:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Ruide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/34255318335

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e19ab20991c2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1160691


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
