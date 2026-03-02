Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C229D29F
	for <mptcp@lists.linux.dev>; Mon,  2 Mar 2026 06:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772432131; cv=none; b=OY2XIS4X1xkvPHUuhulFEJMGilBMNwRjgehdciAMA7h30L2De6kLqblVyssGuL2vwofQLJQi8zW0t/m9YmWKh+37ycp6wHXThprol7FnAYDzgSNZO7HugOzPgGScoKHEMuINRjh1ip5CyaOy3ahmfkzEStl4Xegiai2FHcbPVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772432131; c=relaxed/simple;
	bh=l3cKhKBDXj43wjGLFuq1Ma9LbJaKGIX9dOmg0NryJbM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=BdUgCs0+ZGb64o9mt9S+YsK0C69tAU432YLiDhW2a8UrH1vM3alfYe+vyqEYq8NSiHllf8kYZbtGS9cQjdbd7b91djgl9KBSEybnY052vLECQoJ4v2MzePp/Xmr/Id08HRBw3Pjt/PLNOiUWfZ5T1wb3lUoFfr1gxBmnMyUArv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew2akhgS; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew2akhgS"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdfd262114so2193525eec.1
        for <mptcp@lists.linux.dev>; Sun, 01 Mar 2026 22:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772432126; x=1773036926; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Sf+jJFjtp4hRI7mY+KAI83qjBeHqdYnrmaquUXh3CI=;
        b=Ew2akhgSxPpkCnw/ePvY218+u8imo4mteuD1gAtP7haf1yD/bE3cHjxzvzmyggm4Mo
         //eRlUWd+sFnBeUNGRucsVE53Esx0gOuPNsEaxJhpmSA/MyW1zAWbafrGAfo5tXbC6YM
         nQbBfgkjFu082QwxTHcc7SJdJlNxW3gy384O/wh31A2bmKYJ5aXXn/qct1TPq/MQwgud
         I9MdBTWOYNrHAQKj9x9ES1ydJHfyiFRMF9NjlG6MyZbMLZ90TJv3RKRIMCKSzWl1zsD4
         n02AE8zzY5bcQ2NLMsz6CYjonaU/73IhQ87rBYysO1drdwZ152yJEdMK/rml7b4Q8zme
         Ibpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772432126; x=1773036926;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Sf+jJFjtp4hRI7mY+KAI83qjBeHqdYnrmaquUXh3CI=;
        b=oM5c1tkjb6zdHGz/3zxcFHQ5Ard2RVAFnQxPviflbsJxw03BVFITHP1UWd9tBKFg8s
         5to+gbB4xZGj0GRcaPuddExXZwdFrLFFTTNMIys0dgbubyn0asPQVlbUiG4ZmzscfXBu
         CkbK625araRWxO4+4j4OQAjtS6kfm17v/EvpgQLteJQKQ521RmcnrIbPTlnEIy4ic3ca
         SzZ5TBTRfl+1Un935LpY50ABeJR8o2ud2xKs/WBls0uFh14TonTVCYHy2wzOxm4/DnuN
         9eC/rd/3+VFUc737baNBte65qCKfijn0cYswwdTJ/1MRfFhQo+XKNtjMBOOeCEaA0Fs9
         /pAw==
X-Gm-Message-State: AOJu0YyAfMR1bnfGOxM+NWK9uLlnb9tlfoIfFXWm3LhDIY+cMDUiA8Zf
	2pcIXx8eSVJYHDhZsnlWiIYWvaSDtrbLeMZslM6l2s/PMiDgwLt/MJI=
X-Gm-Gg: ATEYQzy3vF3B6F6EGqYOdBe7oEX+3YJigNwzTKMZ/tINcypDutqRJ1Lf6PmjO5lna5h
	KBAmy281KunUe4zDMOrw55K39tYbUEZpV4P64SLLZfpSYWd9cn2RCq/aJpDOD5EE+3JCP0gH+MO
	jDuEV+Lx+nhaZQL8curLofF+L28V9xeXyN4UmV1HcLfewu2llmyF47ELATQQybeSI/58nsOwSxZ
	0LZInbsYTGKe1j32GFl7cj3cJYxgEXSsuMPW1FhRZjWRKk3/0hhEAbScl7xDFOVV97dOAh30qtJ
	f4YMVFuEushvHKmBMeuk+tzmLvTNCSVjPr+dcz3+TvW5sAsNOuv+IBMByRLhIQpmtrrH6736cev
	cmDIQ9UFyoVlk30uvIAGlOoUvQ3MejtSnjAdTjRLv2Vpln0UiDiVPHVga7riyShZIBL5g0WJoJY
	zYeuabnvmNztodBwrUZCe+d1K2/BRWJOOLfK9p
X-Received: by 2002:a05:693c:609c:b0:2bd:fd23:72cd with SMTP id 5a478bee46e88-2bdfd237b3dmr1660688eec.26.1772432125531;
        Sun, 01 Mar 2026 22:15:25 -0800 (PST)
Received: from [127.0.0.1] ([128.24.163.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be09bc9ec4sm3200582eec.24.2026.03.01.22.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 22:15:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260302052651.1466983-1-lixiasong1@huawei.com>
References: <20260302052651.1466983-1-lixiasong1@huawei.com>
Subject: Re: [PATCH net] mptcp: fix soft lockup in mptcp_recvmsg()
Message-ID: <e6f59a7a-18ee-00bc-2efc-8747ad4b8e1c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Mar 2026 06:15:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Li,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Notice: Boot =
failures, rebooted and continued =F0=9F=94=B4
- KVM Validation: normal =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_dss =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/22562459750

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/24c4916e205e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1059774


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
