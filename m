Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9166CA52
	for <mptcp@lists.linux.dev>; Thu,  1 Jan 2026 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767292476; cv=none; b=BAZ+EicrBpGGj9O7C4LQP4aBnJP6fXunRIPSbJjAytB5QcorYWs4zernQQarJmmlCCLCsM/Xr2OmHsAn1BGQQUAvv8FtJY3+aHOLxGXVUKGU/tKUceOMWKWAGdO2Vpvmat/5r6vzdnq5/mBfuWlUNuB4YvNUmqwHmRu57/RfH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767292476; c=relaxed/simple;
	bh=vkTgSXSKxGQ/edmZV6HlhL+LdSBVzudmzJzQqrc3oCo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tqdAoY4/tdPyxREl55N26g700AA2rFjEmW7aCtA5ICMXVFcO1/N1oCr+ofXQIgIfxNWT1X0VE/F2UFnBi+rHAhj46XGclafdj9Bx4fYcJso7RYJaEUd7ProdUneDSPTDAPEF8pYCel0mv73uFfL04hPyVQnyg+Ai87YhXDPKcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKKMJdev; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKKMJdev"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c07bc2ad13so680803685a.2
        for <mptcp@lists.linux.dev>; Thu, 01 Jan 2026 10:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767292473; x=1767897273; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCig35b5XbUZoS3dJLmSfKdm2mnPNUyE/akiICn4lXU=;
        b=BKKMJdevmGDY4i7XuP4HHr4YsWt5vN5KJdnTZRErPFEAGkgLzaXVMBphJ2TWRJNseJ
         bb6uWivQ+4yhbIMRRkeYKWI6wKEMSZWkXYyDOZrH0jIjFJSvuwkMkRWTLuaCYKT7LV6z
         F5YDuQj7aM0BYPgTLNtQWiCKl46G/CtEqA+C+Qit+U1aCEdcl/LWXtdEr2vDoo8KHwcT
         afuNA4h2pzNdUCJk9jppRlFA1Cgd6P4gWV6qbbWaKALCu9X5mFDyVR6aAEXpYcjEctDm
         ViWPFTZ4EUvikS2ub3qDcQlebg9FGMdVlYXtj4FfXvoCOFPKRolK/u8baXJhRAEkbBu+
         +eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767292473; x=1767897273;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCig35b5XbUZoS3dJLmSfKdm2mnPNUyE/akiICn4lXU=;
        b=al9/LWbHuYbGjbAmhWAc3VuMhGk+Voj8NAn/OKOnKkxzaRUj7KC5qpLLhf5yY36WlU
         ayAaTO+YYt9p9A7mBJ3fwXm8ghThCyfDkndw710MKT+cguzYL6VltLUtN+fz9p6xOhJJ
         SjMgavFVRbCEZw8rl9Ks2ueGoqJMsOuN/9HRp4ag/j8x3PNbebFa3iUuXyq5uU1QtitE
         kxuaQWkEgz9K4Jjft6l5T0sh6TIFfzuhFqN3CaVI/9FgN5rYOKvynXInPq+iT6Bkmvik
         95PprhxgNeap0l1p8ugF/6vxTEXHexAJF41vnO1CIyknyqR5/iGgBHQwgb/yvaueruAv
         LKaA==
X-Gm-Message-State: AOJu0Yz7BKbgFgzipIS5heLJ8u2PzVEWAC3O6GBHAsbfLQ/grIa7VhuA
	NtZjkSez19DYhLkh01avP72EsjNDo63G/hkHI6tFYJ5lZ09dmC+B6Uk=
X-Gm-Gg: AY/fxX6tOxuZvWLlQtbEUUDowVrzQl77pDcLB/gmlklGlercz7WFTjpurgsCuKErBYL
	QMk7g7YJdTSWZe+Rwg9HZVRsCqi0nF9GQV8qbEk/zLaiOQVsLLhzOB3KJwjhrNxSzqmglrLYf9d
	eBEDKiCGtmq8eOZOPtMllB7gVSxXqUCSe7Yogdctt/P0L0aABjSctgqZHsKdB5mAB7Mm5zcCBSZ
	xwI9jt8C34qChIiPq/pEk1xQCdcxE1NZ3a6nx1NTYUzYl/C1ZHguutWcjo/tgSUJjEBP9b1wKgi
	dZ605dQE5LkMDAT7rvZCvCUF41Arc4bjkZfGfav3RGeiv/rIlFQsBhON0FibnFSMAQbK6sANfQb
	gf4lk3xjFJrWpKZJIWUT9QHgC+6AuSspLTmGOBDZGuKF40h/nuTs3EvFZpsLzgGEddUc5Xl4YoT
	eFr+DM43hK6bhyi9zX4wGWAeW4lD7gZyBb9fU=
X-Google-Smtp-Source: AGHT+IFw5wK3WidF72MQrh6xXXhoVZDMdHjn2RbQNQj+6yqppM1hCSiMBz1GZ0iUkqboyxcN8Mwdxg==
X-Received: by 2002:a05:620a:444e:b0:8b2:9fab:d7d4 with SMTP id af79cd13be357-8c08fbf9e7amr6298503685a.38.1767292473508;
        Thu, 01 Jan 2026 10:34:33 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9624015asm337473156d6.6.2026.01.01.10.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 10:34:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260101172840.90186-1-ankitkhushwaha.linux@gmail.com>
References: <20260101172840.90186-1-ankitkhushwaha.linux@gmail.com>
Subject: Re: [PATCH net v3] selftests: mptcp: Mark xerror and die_perror
 __noreturn
Message-ID: <0dfa9a53-15c4-f704-73a2-ad6fbefc6435@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Jan 2026 18:34:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Ankit,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/206428=
22498

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4b6275a5aee6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1037823


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
