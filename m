Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA517993
	for <mptcp@lists.linux.dev>; Mon,  9 Mar 2026 04:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773029253; cv=none; b=jlcHOHB64YdJpLAPt91dv59uWzF7mn6gUASJdOqD8OqwpnjM0KwvLiA0W75COdkIHud3CVjFoqvRxoF0jjhBSuovXVFXyDYq4wFi0RBtHzXbKYvn+4k2FS1hQpyeSorUGoZMhCpnThSRjRpXV96MtA4JBODHs8vHF8Rox9hTpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773029253; c=relaxed/simple;
	bh=QLXf62UFxvYI96HBdeCdB6UE5V71T+S0lxbtygFt8S0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OPWASm7z3QffqAbsH0+0/lHZ49n4cwJL9tddxGocCsTILXXyjZu4i+XC4V2hK7TpcdFlD65/ut+ipgjvrtFmkvoukr6aH1wj9irJL9iIMxHMCjQwF2HUn0w9axEA/A5VN30wIhv8MBAoctWfwzg2EwXtdlXCiSs1jZlp6yhsdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBPLdLV6; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBPLdLV6"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd7a75c680so123268685a.1
        for <mptcp@lists.linux.dev>; Sun, 08 Mar 2026 21:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773029251; x=1773634051; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH1IUU8kUFUqQSfnkgDVkfmxbborNHy/Ry5K8/QDPSo=;
        b=SBPLdLV6pYiSLlVCzglme6M30DuP2oVnX3+paOpw4PRe7BCywrAjxEzCIKODLejI08
         S+p9BYpAcUU+aGFCqoLCevT4XONU58+LgW77DTxSUPAY9NT6TPb00hk/g2ka6ot+Tb3j
         2l9a3epg51sq++A3nd+FWP4jVt5XQE+QeP7dGijOclrURzwPCcEU7QEfaon1VilzC+rf
         VQ7IPdRQ4kA83kd1YsA2LuOekf05Eahu3nWqWMXWcRAEah33UM/Zw+v/rjSp/P8KNriH
         u6GyXYFxlgsqeIWpCa3g11L7U02zcCQBLApCQAZUQrcIuD7iijBnxosef5mBEtGHRtOY
         brFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773029251; x=1773634051;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HH1IUU8kUFUqQSfnkgDVkfmxbborNHy/Ry5K8/QDPSo=;
        b=KIcf54lj3LQz/Gmx11HNoHNzR8ccG7xlNUHHctyiFu0Ysne/7cMeqVW7J+RDB4zGI8
         ARJukD+cmyZ0MLJflLMxWtYMQ1y/0l9b7NyDgjT+SgiDc2ENedhma6YoljZhjHAYW9QC
         9SCQEJK2TcNuAHL0GRX0scWIuPTIVMOFih+rBZfxAMAymxEaMxI25xHCkJt1HlAZORY6
         XKXP+F0cx5ZcjBQa0vvh8ZtKtvxuYUOLXJVSTPUvzDNkoGIsmbgEr7B5ekVPtUL/4lLl
         JoRkCBWIYWmi1F3eSa+wOUUqtIlb/NmXVZU9c0iTMh0EPpXwtGvXOi7UMzh1WgSD53DN
         4uiQ==
X-Gm-Message-State: AOJu0YygcmBf6Nwxau0JeZ1fDn0BJP2IDVHR4lKZDyKWll7V+QW2VUCO
	5IwCfJx5SzJrroowcLYDvKBriytUND+l5zLst+FoB7qPY/HSxeupbfC+ItMg
X-Gm-Gg: ATEYQzxkG1dJc1GB8pySzgFcV+ca67atg1jq3iPkkXiE1MUnZ9xLflE3dfFhXJc+Owj
	mktw5Ravj+/mVy62mRApLEY3C5PDoAHI+skPKHSaN60sTWBau/ZQXAnE5qywijQbxXkzAM31GPx
	101sfP701OLCIwWavEK72TO9dnUyMiNVb4kFiJ7Xg9/e3ADsxfUSCV9MwdpoYDq2iI9fzMbx8Qj
	eDyXbSf9ufaPT/9umQthgb8FsQGwa5UpblFUB7uhh4lK/n06geMDxFBbwr4v2BgrSz70pLg0vua
	cP9Fb5ylyB9DoezqT9Ggz7Str5aMn41EwwvJhcUgf0v5pbz1J0sYazaR/CvchLa0MOOGHLCuFap
	wTPzKZlUb+6+PlQxL9ATvVYZhCPRXYXJAxoZONZrlUAM4crEGYIxrJhgvVuAgjq8B+l8E9WFVBK
	wDotiB00aDj/+LmUDA52byy5yimShfO8+iK41gQD9OJoEhEIg=
X-Received: by 2002:a05:620a:288e:b0:8c6:c983:dddb with SMTP id af79cd13be357-8cd632bee0cmr1533168885a.0.1773029250614;
        Sun, 08 Mar 2026 21:07:30 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.103.21])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f53bf4esm676745585a.26.2026.03.08.21.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:07:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260309025431.125943-1-gang.yan@linux.dev>
References: <20260309025431.125943-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next] mptcp: preserve MSG_EOR semantics in
 sendmsg path
Message-ID: <5d73cffe-cc0b-d280-e278-d1c75cf3308e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Mar 2026 04:07:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/22836823300

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/070dbf41676b
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1063383


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
