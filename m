Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102A4C69
	for <mptcp@lists.linux.dev>; Sun, 28 Jul 2024 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722141613; cv=none; b=KhIhzBFFzPpwFoAnd8EV3kgP1+fVzJtRqOcWnkE8KsgE9+yh/hSvUjz8oOuI1PVn9I/hehDIGytTxdPWQy2NtkCg0VuGq0A+Y7WL6hh793m+GMZsjUQtEQ/zazcPQWE+J87bXR3pM6IqGo4iFmtaYxzjRsCSK/+8FbcHWn1huSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722141613; c=relaxed/simple;
	bh=CROiiVxHU+dN/vE2dWkRKg0ZywnG2zoSD4mF8XlcjwU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Uigsrnv0Q9oie4/3R8lC6zgDzrGkhHjl4LmUVXmSWruE6kkFxO2fs4giYMpZpzHpHIly4zxytROw5Zt5WkB6DHjNwhp9DAgMWBxP6o5ags8gwI2NyrDumsUXYjXE7/LwI6QIDEIGomZ2ydfsOctfxj8D+uIqdk+LnFu3OFGpvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Wmmx3z; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Wmmx3z"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fe6672297so11897191cf.1
        for <mptcp@lists.linux.dev>; Sat, 27 Jul 2024 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722141611; x=1722746411; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnVE5vRDRY/cp7Zul7PupDLFcYcyrk2N7Vkfvai1Fbk=;
        b=J3Wmmx3zgUVczFGpHRdKMt4SSqGUb1MXI4aalcMA52WlTgObTEyASef+zeNoGDXDum
         veDvhiuDXLJn6RmZngVysa2C4oVGwpXTWsqIfNNzd4CgBnZAr9eXfc8/e7LS/nbj7s14
         At4T+fYh8LQQ3PwUoLrrD91lg3aDqebUp7cLW6hJUs3gzrHcZuuZUORVrJgWp9CIg0/+
         u6nu+auLCIioekuaRcwQrsWz1RiGCjpycXDzlYiZRRCX8EG3aP5J7/deHePnGb2yBn/4
         H4CBF3sUT8PuwFQf3E9r2XiQ+OZvfBOTilfCRpDsReSLtOYARuKJnJXUkTzJNQFXgr6C
         +hvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722141611; x=1722746411;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnVE5vRDRY/cp7Zul7PupDLFcYcyrk2N7Vkfvai1Fbk=;
        b=VjoUkNDzelGN/HfD1Ioec8wMZSOa61GBN54+O2YjKrgWJ/qqIdMJqVcRB3Lr6Qt5DD
         spnX35mFX7MI0XOKus5uVTr8V9i3ylOKnNxVpD7qfgmA/YpLqh7fpNrdr9kFnHxgUIFo
         grn9vrVpFoIRVTYVDGVloR86UobJLdJ6k6W4s4LbR8AkXm7+ZA4dqgoHgzd6nQ0rD2Lg
         T1st7rBMvkWtDbsmkNIFwatSmca3Q+0kQTnkdtMYvLKO+rxQhYNGczT45qKCXHQNUyBd
         tqSQDQfewzrAb5iDC1XyW8OswvZR+8ICv6WyVwzrDHpnZsAwNyP1oOSY7cUcSOwRZ6kc
         lwUg==
X-Gm-Message-State: AOJu0YxvbbvrFOsuWssM/tggsWBwMlN5/nH/0TgZWgE58FADR5CrcVEe
	RzmrfTtaa2w6QXDC3j9hvBbD3F2DdbK65CZJ/ScfYe7CHTm6VPXF//WIC5I=
X-Google-Smtp-Source: AGHT+IHPRj0uTJVAHtx6UscZ54iZ0uK+pZZJ/opE6uBtpsspGQTMzINlBixpVGBjkxD+2mI1fTlzNA==
X-Received: by 2002:a05:622a:11c8:b0:44f:efff:af15 with SMTP id d75a77b69052e-45004f4baecmr44175161cf.55.1722141610422;
        Sat, 27 Jul 2024 21:40:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.67.135.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe814ef5fsm30749101cf.37.2024.07.27.21.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 21:40:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b61be1bd6c70121fee3c6e183fb224b41d9dac90.1722138514.git.tanggeliang@kylinos.cn>
References:
 <b61be1bd6c70121fee3c6e183fb224b41d9dac90.1722138514.git.tanggeliang@kylinos.cn>
Subject: Re: [RESEND PATCH mptcp-next] selftests: mptcp: join: simplify
 checksum_tests
Message-ID: <b90bb833-8082-bc5d-876f-82d049c2a6c8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jul 2024 04:40:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10128796339

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/741a7b014af5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D874289


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
