Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA79463
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777858645; cv=none; b=H2OcNRhycr+WdhHgHQteZyZ0t0bs+BRtH4aFwdPesk/3p0dRs54Vykhs0u1WW4KxbnJ/N+1LfH1NmV6wNlfx5qc5lepJmuGPs7AJCxRdKZdZk7aOhuq5IqPGJO8D0HNp7Ff8WDYBHb0fJKoG7SVcFt2iZRNJ0QuClsS+CTwi798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777858645; c=relaxed/simple;
	bh=gIhrMwgPeRXkth5dTEfVaCUPL/VtunUwC9jOhlYtViY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qNPQsv0xiW4M/U+7/pKV5kci3LJSBmU5IQ6wzPKu3LVCrzpPnpJjiR9kX6EKSeKjaoqeEJCkIogsJjudzP3kiRBuqsSOekgS3wEi9nz3FdRuSXQgGOo4oFQwSFOGoTBVWKIZ3/5p4FPHJFNg5IDzwOsJF8JfWliu6nDn10ZdgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/PbYFEU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/PbYFEU"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8eae9229110so643393685a.1
        for <mptcp@lists.linux.dev>; Sun, 03 May 2026 18:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777858643; x=1778463443; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ho56UjPoBAWlbkq7A+dm2BKi/mUIdjSIzZVu7VUmAM=;
        b=C/PbYFEUIMTT4rzmwR/cb2jyMbtB5RNhgtkO0Z6wmCFScjDf8TLDo8zKftltmhTNAC
         ERLwPK+ClHlPbAiaI0rWPVB2B99euiziS/zmefCRcQlQCUG4WqOXeMQnSYKJN2uvfR9e
         zCf/Pfrn3MW350tnQwAJAbr94xuP1o3/NspaONWT7cQFeUT/QHDkPbCX6lqeMWlYH9ju
         JFjofDGZVkOOIwbS9luR3ip1MLvo8glnBLWZpnl7X/w6tQ2VBvTuxAnJfBhW7zW8UApp
         ky5z3HNz9+2trz1z6ZW1GRa8Vfx3EeB8GVBTfMmY0gagtsdjCz8SJIA2RL7o2qcBWuRg
         nYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777858643; x=1778463443;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ho56UjPoBAWlbkq7A+dm2BKi/mUIdjSIzZVu7VUmAM=;
        b=BB+tQHZXx0O4mYbBL5mi1q/OUi+lwfkz/RqOlFoetYhclm8sM2v9Dg2s3lB8SfGvQB
         qmR9NlPT+YbgKmcKbqK+KDZwwfksFc464k1XgwOFLKSjXoZnKCU9e+e4Ih4gqQdxNaju
         cY2MSsEr0H+4ckq+2WowoFZzdrbj8TAlL6KdJsL/6sSzObJhD7quqDB4QQJU539c5XAs
         O+4BdnQH4yivp92FF+VUiFOEtaSnIUjvercqhkQLnvSgRHky39JvzjqG+DGgqQU3iUao
         aEnLotNYZW1It4GMdjTMtN6SFfEWump2te+7k0Ryeada4875t0AjwFBQwPc3S61GGc7q
         DSTw==
X-Gm-Message-State: AOJu0YyxqqZw2+2PCxuVZSydoX9yTnfIfVm+TFZOc1dVyZCPSS/lwkph
	SqwfDMw93RFqdZYYbIAYAgTwcpwMaIMFN2rEROVXTwx9Wuvq23mhAlA=
X-Gm-Gg: AeBDieuRjv+rZNnQ3sdP2onHVPxC42D1qi0BeHH4tABjBGQv5oYqYcC2KBF9u/1EVx5
	lxFrXvJSq3M9p5sKI/O1QJfl+DBb8yAbksvx2kY71O/77B2O0PGmWb4qua60S96qHEoMe5bZeuC
	HWgfslG5unNMb+LlisBDh+FfJdRnTLq0DWUVYmtMMN17wzX//1x0uRtR9iuLKuXqisLcp9KDLKp
	Wvbb9jTHFQfpU3ApP8yC0wfQHCWDplFfI0qpUWPKiDvYDfWc6NhDJsr0XBD2z1C5qQpZ8/dVjh+
	0AaC0QeWUHs5c3NF7lcX2Np9trrzPEpw4PBeBnsHKYAcfxkR8bUkwa/ogkDfvR3JMqd7vyyN+Oz
	V7w6Vz4HWII0uRAcw0FgGP+eLa58sI3Ydu2JqPP84WB6dXK+KkQIm6OLNGXzteXV0Ptl14PU6zx
	WdI1acgQsISkAV1BugPHHdPzkNvxA4DuHBDubUf2xRXDpp+A7Q
X-Received: by 2002:a05:620a:4891:b0:8ef:f1c0:ab7f with SMTP id af79cd13be357-8fd164c43c6mr1225697185a.24.1777858643063;
        Sun, 03 May 2026 18:37:23 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.80])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc29a80784sm909884385a.12.2026.05.03.18.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 18:37:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260504003156.11125-1-kartikey406@gmail.com>
References: <20260504003156.11125-1-kartikey406@gmail.com>
Subject: Re: [PATCH] mptcp: zero opts->ext_copy in
 mptcp_established_options_dss()
Message-ID: <6c82a695-9b02-6cdb-6cb0-988d67095b00@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 01:37:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Deepanshu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/252956=
68463

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3318919851c0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1089047


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
