Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8833DEF7
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715904; cv=none; b=UJh8O1sFN+avEmrVPZZuZKVkxR4pRwwC4weYpJiKzDZ5141rICRicFA6F++PijBkVDtwicYNqjMeVKmmwyCXHAnKLpSQSAX46YaT4K/d+7or+3pDn5FGnWck81TRpHbNXasrnsrzDwj0je9VoxdM5RVwIOQyMtn2ECmuK8PgOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715904; c=relaxed/simple;
	bh=0yXKq2QicHtkj2TVJ1em4lR0Oq0o0eU76roRNNYgbK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Q7/17KGZkXc6cGfqVBfICJIqdU7qy+C2fnhvU0+hfTm3KTSab6h62DLYhMQkVMTMExZyi4YUWH0+aHQiydEEI7u6wUqu9pSitAmYSanFsLe2ya5fGLtCqSBobcROKsRVYMbMXi8BlKAZDgOFeq+GNzFk8SLpUx147CFunBFFQwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3cXFxJ7; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3cXFxJ7"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f0ad52830cso12161451eec.1
        for <mptcp@lists.linux.dev>; Mon, 25 May 2026 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779715902; x=1780320702; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMFbY02EQnMEzJMD7zMR865VhQ3/7ckhRaX1Oi866jU=;
        b=Q3cXFxJ7Hj+CouR8glCMID3usa+u8MeJxJgUaews8w7OW2XDwm0sLrq9YGU7lz5V9G
         yaiTI2b62sSVXx9XD0h+6f3KTIWXfz6KELBSXFmWFOt+HBsUhHjTMR9ToW52T+ZjqIwx
         HTIBwPGB+MW941ibr/8r9w8vrQkUEZuyD8OJ1RpQUOk9jSggzt2I6EqN1I6E9t1E7UbS
         seJJ/nBlqZvARs/jo4XDAn5eQphWFlkBrfj/Uhr5AIPnZ3v5vF4lgAfLkcTioqa2kdyc
         0RQV5h18FbFHH7GWOD2PtkUX6pTfAIgPTD5VEDAKzeJqKXDDnSJ2DvyMcsBNHT5gJf2Q
         1pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779715902; x=1780320702;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMFbY02EQnMEzJMD7zMR865VhQ3/7ckhRaX1Oi866jU=;
        b=PVRvP2UJboHK84eCXdPiMQgsIpBQQq2MRL95H8zX5Ci0pJvYBTvpuB589owRJ3HS46
         8bfG3D7zVUIk96THL9agx780OyUf0vZrGowY+Thls99Oel+WKLBTTpV+PDVCCIlq1eMB
         okkWuGFEgTtdLH39H1nn/Eg71lBhHvdSFKGGDPYbj77CAJPexbnL3n681TpK67nRjtro
         yipd8HtvavF0iJEygIzDybm7lD3p1mXdYqog+5YyYhsvdLHMMv0jJN8kqcJ0sVeJ1nzj
         wDLic5WmYrKu1inyFysMQvWl4Ld+gLAkdITBPpsSbnBHpULl942UY2UGM6UoFvTnRMyw
         XbZA==
X-Gm-Message-State: AOJu0YykAWj1OHK7ONBiHjFPGsM31+6Vw3OEYi6sWdTwFOV48UQULptG
	fGyJIV+Sa6NuF8UBlSXXZtmuurJ54OYyJn3AXTOC6o8Xq0Dr0kf/cXc=
X-Gm-Gg: Acq92OFFPYP92rGvv5QwJiqc01nKE4OYc6bY7CamGsQS5ckQ0FWnLQsuDxxz5jLL2UB
	3EXIcYsmUA5tEc6DjMfPAAAb/Gjf2mbqxbeEVMUKmu8oP3QxBe7rZC33S+Vu/BvMNYeFJ0am/Qo
	9rJ82znLg2dKTSUM0iPWSnldUcqBT63uVoAvfTwfmoFcmzOyi+P61QZxVSR93O7WhV50bN69+p9
	9SHcF6KtT+YaOUghJ3qx74xgSvWOWUpW23CkL0jLxCm5Ffsu+2BB4impeZutZ+oOjsYByLdrFvb
	IE1HbYLqfdT6qLNtH2iRTFn0mUutZMYnAKTbFepHpWndkeI3pqBsPVT2rxDp5V7jrZfGUArCvDS
	VBVjbKCZiVoBGOr+DamVunXRgkmUofg4T1YA0HWwA7oDvWXENxCyrWHOVrkF06FDsAgX+bgEipH
	us5893X+JCEQ/2zai+CKEZB5IKPhbSeuPceNtOxg==
X-Received: by 2002:a05:7300:6417:b0:2d9:6373:ad0a with SMTP id 5a478bee46e88-3044908d336mr6369968eec.11.1779715901872;
        Mon, 25 May 2026 06:31:41 -0700 (PDT)
Received: from [127.0.0.1] ([52.153.130.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f1fd1csm7798903eec.8.2026.05.25.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 06:31:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260525121911.2410171-1-kalpan.jani@mpiricsoftware.com>
References: <20260525121911.2410171-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH] mptcp: pm: don't WARN on re-announced addr in kernel
 PM
Message-ID: <4226fff6-9c6c-0f9b-96a3-cfc200ee6ff2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 13:31:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

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
com/multipath-tcp/mptcp_net-next/actions/runs/26401003887

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0d0a433a605b
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1100453


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
