Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4185625EFBE
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801721; cv=none; b=Xu9FBnFtJNzuyKXh8RpMc6XwvcJyGLliIqU8Pb9yzaQMOu6TvWT81XRi8FNA5i1qYV8vUPWCzyrUDDiaPTiBNhuzzPGM9V31cZWYlsMDHhRAcmZGrOONVOYnJr+Ij2iK3rd/FQdqoF1vGe9JOD3mOoBUMq7yZCtJ6snnVaevXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801721; c=relaxed/simple;
	bh=kFs3u8fhSVxoSGJBNazyCnEZiZ5l/ABOYhUclnOBMxQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=emoJRzVJX5YRUxsWvQtVchYl4D5EUnOepR/R3Vd78jRTol2mTNx/MoxBAD+Vuftk5HGTo6M7cXaXGl2Mpy9EzVh4nj/xBkOKUPgs28H/UQYWkpD62R6bNcQsmpwUtB1UrfBae2MCcr8FXgkT5fFxkHzRlbNYK8JauaPyfyC6R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYM0qxTm; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYM0qxTm"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c5384ee23fso279160385a.1
        for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801719; x=1770406519; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBHkGG/lleSGfUDZHxbBMI9EMMXe7Hh3Fgrr+d6WjXE=;
        b=WYM0qxTmGvCoUs1pl2rGFHS8Zig7/Irx6XUUYjQwqOr0jDCFjEyxhdvRv3+DyHdZdS
         ydPDD70WHtRnE+dRgpPg7m3jCFbBkz0FrtC+eJc4jpYE8g31CvsmbW+dZKmWWPrgUvg/
         UKSXsieFRZne2P2NCuxRODN4bwaZBUYZomPre4bKItnaQJmC9DyR0mExUPo+tmraACU+
         XW1rnm0ItSmgzdgfxLEbvfiuUBbK8L2s5mJEDJqCbQdTsoQg0ArRgGTzglG5uFgoFUOM
         veC9SAlSCz5oW1oD8/Xz4fzkWa18tFtUOGNxSmxeZY6+9lE0kdxBswtoClQC5tXxcRN5
         QS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801719; x=1770406519;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBHkGG/lleSGfUDZHxbBMI9EMMXe7Hh3Fgrr+d6WjXE=;
        b=SQA+xV9QJh02ybGdhyOrHyutq4gVgzMqGhykXByFPRfFptWEawnFzMhCJMj6Pg8+P1
         SMwEYIVd7xw3MDPEkv6vsnommZlVdpFqn2rdcRXdW6c+cQvQIZhxJXAILVgJrn7h9GVw
         A244GFZd2G//ZB690vpgz5hfxqh2kfbHQxdRt8o4yyuquz+EHi++KGa7PVrwnGNIjWhe
         1KzQmrmEbH/uo1b4v21+yCX7suuIkSgTnBACClg/uP4cUmulJFolLyCxbyVS2TnTno1S
         UIZmggIO75wj567LIBjC/d1oejYGLK/sZEzQAv5vZONm4HbWfuMIgSx/mEdlXHcsS6zt
         Dm9g==
X-Gm-Message-State: AOJu0YyMZ0box3VVSw94b0OR8ylNqGCm6tPgKT6bE8fg9Vd+bYWxhkan
	pGFyC16AITZa1dNam6FFXYCwwqTvpklHRylY53RACmZA4VngQRM80OPFRuCp17Y=
X-Gm-Gg: AZuq6aJFq1AffSJHxDJTOSzEB3AppJ4zigZtL+pC0hItdJAROfubGJw1N2j3ie4cMh6
	yjUDuCV2hZew4LtY2W65Xxc+6Vq3d29oQR68RSr2DMoq78Ny8oWKUyCJ0VMMALbPff3uYc9c6pI
	TRzkKlKStqG8Bdmn12fecQ+K/PpVONJSBk9fQjX/KNAApAdk7vFj+QKVOAbi3bHs621H8SNqjt+
	Aq6GqvGI4UJCytPBzKEZowntLXIM34NfSiWejzNmaE1ZV1mu9TpOi5liSDQdMum3NebH8Ash7At
	GAr4FSxAvoPXM6UbCCEFzXz8Lj0puQBhDDzEdcg+XvTzXHuohKM5Cz+m/9jyDMQ60c5D7u/tumW
	rDIj8bxefc2ghjIZK8TUnS9fzpyUKLdV5SCHP5OwJEBVRVm3g796CspL7KtIrkO8zvx1ThoYnKm
	WkEw2V4f4m/wIbkyJp2kmJcc0=
X-Received: by 2002:a05:620a:1aa0:b0:8b2:e8c8:671d with SMTP id af79cd13be357-8c9eb3422b9mr529404285a.60.1769801719021;
        Fri, 30 Jan 2026 11:35:19 -0800 (PST)
Received: from [127.0.0.1] ([20.109.38.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b95e4esm767105885a.15.2026.01.30.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:35:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260130-mptcp-sft-sort-includes-v1-1-ab022fad9741@kernel.org>
References: <20260130-mptcp-sft-sort-includes-v1-1-ab022fad9741@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: diag: sort all #include
Message-ID: <cca093a5-cf76-ac45-92d4-aed7e44fccac@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 19:35:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/215266=
68294

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aa1975519da4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1048929


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
