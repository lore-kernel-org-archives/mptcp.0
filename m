Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070C3112BC
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157591; cv=none; b=erBmBHlDLA67pHBZ7Z9CyMLi2wbwmpcqgFfUjUU7VHalaphY8zosswgAqRWoCuHheKP+bDn8JDl5ru+opTFTqz29NkKYpSfHAsV0jDRgk6ZeDKJup3hdQBPpOmrZN62YzX1we0isTX8Rka9Bm6AnB4AQ6rtM3vYRuAGGCWiMA24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157591; c=relaxed/simple;
	bh=fB/u8G8IAKDd2X82hJ/SehizmndWjZVlidNd6DQ89yw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=X0I/58/lXUKU0/MdWfecokbgbEAo0CtDeBlROXunGtmUai1iC2VW04AQ8zYxpKeck936EKU9rAS8ZIOEukXhPsxTc8CyzD0ZAQO2zkT0kuPXzo4eGFur9ZOajxP/XQyE5WXVOUAl5g59ymmhSRmW/0vp2KSiqIJ/37LQKlGpRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/DFtxcv; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/DFtxcv"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91541fa94aaso79212685a.2
        for <mptcp@lists.linux.dev>; Sat, 30 May 2026 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780157589; x=1780762389; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhQ6Yx+d2bU4fNtOj+qhPdlkVFOa7MsXStDyXzN4iz8=;
        b=h/DFtxcvSkh2orcxIwoK4OU8rOw95ivfzlsCNDAXcvqSN7UJp+W7l/TxealM3LPuFP
         iwmbA+0glVC1QuDeH8q1Qoc+n6qakmmnGVW6hYvGnZvDdJNqts1fNfrfodjEo4i6GBzh
         2OJS8HyKf/uotX5ikY+uTMaEEq1CUprLhbGz/6DFaeziBDVoKrDk49slXQaHcwhQ8hQT
         wPe4aRY7NFU22PWXzSHMSNMYyOmdRUpepBpv/qJPZRWVI05ni8lCeKUlHaTfJa7uvmsA
         xZhg5xNBnb010LdM2RJHR5tfKfz0bxnPedBp9uQuvVSmZeJY/sD167b/Z2YLpPwxaMxM
         dlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157589; x=1780762389;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhQ6Yx+d2bU4fNtOj+qhPdlkVFOa7MsXStDyXzN4iz8=;
        b=AyXBhjKo0uvA5payfl/JDr8BWN+dimytnebS5ORblfyVrvKzYR8BjDJs1KS00psa+e
         wdQeAu7Fnh8oEaAanE+oltjWuAkzRKU1MZ2zBjfx2BuduZZg9LX4lxX24NppwhrWNuZW
         IMJNzVurZU5Ad3FAV7fDBH+uy3s7Uu8HPu3pT9c5Jd9WTW7UrGZBGOY3L2JCF7RF4nzc
         /SH+9oRhj0N4yAi7WQ31Yn9ubI0YyAe/F0hCz2PhPLdnXrHKBEjmLMlt6ZnVJDk/PPd6
         YBawun4yViwbxNW9fMndOI7rgcYeWLVNkZvMFHGIs0s4HMKwLeIR/B6jGMShbt9i1LEo
         jfdw==
X-Gm-Message-State: AOJu0Yz6IXfUbk1g8cUE8l2KVkx1Y+FfRPhe7UueHsMQgwpDDqKOxMHs
	kDJzftdbIoOkdxSWVEErfUq8W6Xtu+HCBsN54ngBYZwI+WfTzRcx1RM=
X-Gm-Gg: Acq92OEW1dUj6pOWjt4r0Zb0fLPxodK6TUSLhctoyiiUdSxOSLP2bJqWVZtEGzWaH6b
	O65mbbXzmLUwC1yY5/9UTZoUIvIt7H4kIqB8zlVLQil428FVh5dZgJPVzCyn6dlPkj76ehLJSg9
	eA8cKplC3EC86ThbEfHW7BxKHYTqBzUDArq1bELXU9rU/Tj4bSdhx6A1jMDnL4lczHT+89eLvLM
	VJwhVxZfsgIob6Nxr/xjOyz1OadN1ghsDGxdU6VoNaBbOr1yOPZwA20XYaSUfSU19OEIXZQQFIY
	SffRAWvhTpkzaOaPlM1cq5MVUfi5FoLokxtlCsJQvcLW2eaSfZ5/McGfidLIpeJhjL/0RmEd3RL
	dRk6YFe+jDQYjgXx41Twi2kw5UWsHotj3zDBRnFUzdMkv38rgirPqbaFlft0zbVr8Vwl18joNcX
	N6Aat7/91kzdtGqN/J98lD9hD2HJLQmbqq2xZAE/bA08YI9pHd
X-Received: by 2002:a05:620a:2893:b0:914:db40:9be8 with SMTP id af79cd13be357-9153da3c09dmr666380285a.50.1780157588906;
        Sat, 30 May 2026 09:13:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.104.58])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532445a83sm528297485a.10.2026.05.30.09.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 09:13:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com>
References:
 <406ff2a2ec71581f6ea6e7882a8ea631c20e23c7.1780153732.git.pabeni@redhat.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash-to?=
 =?UTF-8?Q?=3A_=22mptcp=3A_implemented_OoO_queue_pr?= =?UTF-8?Q?uning=22?=
Message-ID: <4e55b21b-4598-9fdd-bc28-f47be9e48d67@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:13:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 3 failed =
test(s): selftest_mptcp_connect selftest_mptcp_connect_sendfile =
selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26687492560

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8b6df95aea3a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1103335


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
