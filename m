Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C53A1A2D
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835726; cv=none; b=SCOY9dUOXQB7Igh3t+Gm/5+be32wVRteB1uyAX4nK2OlgLkyTO2gRNzJ1XLuHlQfNjq5gscNhsbYnOLIAW5IrnkMP/8dEKQ9c51k2/fB7OxIO6T/pwk1+bhoUbXGg1yT9p6qZ+SL8y+YqptQb+pcE1Z+Ay9kFJ27SHTmkMFOSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835726; c=relaxed/simple;
	bh=fPGeuxKoaG6Ca5PhVO5rLXbbzK8RAKbiPiqXUO44Eo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=sCrHk+svnTMYiiwmEJZKtvTBnXTUVAnrhEXklqjrUQcxxvVV6kxffR/eXq6GC6FHdhlCqp+N3Z6Rl5HRPn1HqBJ3jWrSlRNfpraIwZ/Br22Mz29dL2NHf8K7IJ3NOGnAggRtyynwkA9w2sJodof+ybgr1ZieOeIYI8mVogczN4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzCp3st5; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzCp3st5"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso1263875241.2
        for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835724; x=1776440524; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJJHT7DmJJQ+906r6sn20PPvhQlZENH6F93jdxCpRrY=;
        b=nzCp3st5vRE7QPDNiAKLAAc27y7Umrb7jimavZxKg4yayBDYYcqFeEZk6ngh2bxjg0
         dvLj2IVXON/UaSFKtTFk06pakaDq+V8Q+/E9Gt6CT25cOno2f367L3aWa9LOecvmn8Vq
         RBejzOTdCOLfYXFPmOqSDHfoNV74lITsqL8vZw9U16S/g/RBe9zLTYMGslHGLqVznFiE
         NEmCArAHQrPyxgtzu2Gk5u5XWQmkEdg1nrvtyuOmHhNCmq4Cw+CNqmp6HOSCsIHpIi9X
         Nc/UxsFS0zFBA9rKYPIk67xjONrZ7JrFhI3/RV3jyptr2wwFy+yGzMyredYISU2/f3Je
         EYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835724; x=1776440524;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJJHT7DmJJQ+906r6sn20PPvhQlZENH6F93jdxCpRrY=;
        b=VIAbav2lidOIsfYuYPLFbRiyLzr9aikG4w7lcnWG7035deOSKQKTByusy47X8Swq0K
         nXDkToMNesQ5FhDuRJMQBKssox2M7aqKnEUdPBaDvdX5h6x998/FMBCihMHbS8ijHSfM
         al+o/GlIMAQW+mWdO5pua6w3N5telT32GJhGaklPgLYv6LwsJHbg7tKi0v3FJq3fK/fX
         f9wlvhr4JP2zbhASoXaX2/xJ1VNlJubyIURDXK7kOy8qnsrz+aIKdJbnhRBf+wZuuJqu
         aCqR7BBgI+N/mGLknRlAdc5qJSk3aJCpZVKGUZMZA6TweH1qGtd2mGeaR9GYToYeh9Sa
         5dgQ==
X-Gm-Message-State: AOJu0Yxat+AwsOJiAaBmj4dLr6BNDFWbkGmjvD0ygAm4V0vez9pEN3pF
	ae1CgyvqQzbYI03RZU0/uGMk0vO9aQvBq0qZuqAuM64WFOAUJ4fH07SCvcgi
X-Gm-Gg: AeBDieu1Ev8DRejFBhzmkchSViEBx9hu6sLR0M9o6fX2wKKNe3MYQHSeMxSEFgASgQr
	B+sl+X37lU+1As4yQI4DX7+BM5GrZy36JXfnRgyMhk1/BhpTuHcujbg9tfDtRtu5tbUzQmDCTGg
	P6nQrKAjPO5XQG6VGELLQYFeDrh3oESgzmZ4T8PaKUPlzAZ3belDRD/2XmnNR/q78F7OjSplwZW
	g6vcrmlyZeAikgHxGJIJJEwcoYHVeexQaY2599twy4hcIHDeuls5egPm/o3natgLE7fkz/k4g1Z
	g8LiH7Rk2T7hmdEmBxiunGRJqs40m116wpvhIJVVIT4GemOzkIWW30CfqwKy+T0Tjv5ckm58Eo9
	CLb/XwW9t3M0Ej6xfrqNVfMo2LYxvFWbCz7dvbKes5E3dfzlImqH2t6rlqkvub+82p+fE75pNF2
	Pgi5cO3Gv0BwW75omPWWcY7fWGPXfnyIrPQYJxQw==
X-Received: by 2002:a05:6102:441b:b0:609:4d86:77b with SMTP id ada2fe7eead31-60a00f39005mr1755561137.24.1775835724298;
        Fri, 10 Apr 2026 08:42:04 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a4800dsm24778536d6.21.2026.04.10.08.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:42:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/17] mptcp: pm: increase limits, and
 related fixes and cleanup
Message-ID: <152ae6fd-a622-acf5-c6b1-bb4530842f86@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 15:42:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/24248950937

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/512df030c138
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1079802


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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
