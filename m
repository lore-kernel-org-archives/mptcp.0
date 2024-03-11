Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAD3EDB
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710125051; cv=none; b=PC9JfZcC3ObTc5XgqlBurd4+R4yfx4FpGv5GGkRxJXEIl0aW/piDPKpJDtgXZJ1+jesBXWSfKr00MgS6YkYq7QEwMaBhpaR375o1xbf7i0jotrJrjBLCm8zwTzrJWvyFK1S8eIDTWlgZqdqCsVbW+qv/Ce4Ct+xtpN43e++87ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710125051; c=relaxed/simple;
	bh=TyHpd26Iar0DSiiira5NZ1o/Xup05Hp322YegmXhOBY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sAn+GBko3hqiil3P+RGXVKtwGeLeBFcutO/GbpnI8I3zcEhYs5smdQv+v7478AUAbf6bJej26zHH4/ArQrMHQpVsJzpmW8NEgy75sAWgpQeksGu7c74PwQVdmTbwiHwh1AxbB2bNr+BOfLOXiccY7F6PapwxmHxYV5ox8xrV2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxiSB0VE; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxiSB0VE"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so2162608276.3
        for <mptcp@lists.linux.dev>; Sun, 10 Mar 2024 19:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710125049; x=1710729849; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RpJYAfTeLtquZ8OgC7dSynx6zz6rQyon9//7M21/Ts=;
        b=AxiSB0VEkcaXZjrYla/DyWfMMKrmiNorSkWYS7/4qNbdvMSiTCWlNcr64rktKqgXT6
         zPYYj99vkQM4vMRwECHQOrWoAUD+qNdkYYmVIWbwr8ja94AAT+cNxs3PJmfRk/rwMFwD
         s/t7KMVJBtKMkCxEgjXSwDa6i6NgpnPVydQ+nJpuG38j1Hff0WmT5bzRQcMMMW05fit8
         Kq5chq2ExCpZKwhFa9OLarKawpORLxXJhwg1dSKgp22VHg9ePyfJBHJUZDBuN4Vh/5TW
         cQlWsXEj5o1aRbY7EgA8mfiM480scIll+IMKaFjhfeiJ65hT9nK55jti7azN0iaunOVh
         P59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710125049; x=1710729849;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0RpJYAfTeLtquZ8OgC7dSynx6zz6rQyon9//7M21/Ts=;
        b=YU6fsO+IoACNhd1Fu0HOnAdJQLh6a+3FwqlWpZawuqCyC/wbCO3T2x3lqrRzJt8PT2
         joDBv+t2ywoVpT6spKVBd2Be8WZEmRdPb8UIJ9h2y+GcayHcIr01/BNlXqsIia1tJkdh
         Asp6EvOOz16h9dbZSyHDBZyQ7XKb4lBgdRBAdSonmosce8X+vsacaanul/z1SuLWE9CS
         z0nkDUFnTDHlFqJgbnO8gV/mFy/Et7C1eCTZDr6KTfMCa0NiKrfXcmz9sNyXopu7xAG+
         yk3qQTM6SJaXyPyaG8Ftk2r61vh6TtPoys+Zgc5bkF9weIKOMTc135LpdGfUGgQ3QGCW
         AMOQ==
X-Gm-Message-State: AOJu0YyAkJZmT5TxSFb4Xsd4aGfR5jC3AQOfYKM4TVNyF9SvzB2SmzG6
	1EQ1mBSXo3Gxgb3/qEn6rhgF4h3CPTG+9OcAXJG5gvtRvX8alEEpCrUVVuc=
X-Google-Smtp-Source: AGHT+IHAX0c2PnQy5FqXJYhKfq3wcF3AcAZpjIeL8SIOwe1YfcYjBmsHmNz+P3pfK1FsmDW3NHNw0Q==
X-Received: by 2002:a25:dc49:0:b0:dcf:f4d3:3a16 with SMTP id y70-20020a25dc49000000b00dcff4d33a16mr2384581ybe.45.1710125049147;
        Sun, 10 Mar 2024 19:44:09 -0700 (PDT)
Received: from [127.0.0.1] ([20.75.95.100])
        by smtp.gmail.com with ESMTPSA id e15-20020ac845cf000000b0042f3882cd05sm2085668qto.42.2024.03.10.19.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 19:44:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <82de56f853e291af0f6474ba21a366c895ad8e5c.1710121590.git.tanggeliang@kylinos.cn>
References:
 <82de56f853e291af0f6474ba21a366c895ad8e5c.1710121590.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: netlink: drop disable=SC2086: Tests Results
Message-ID: <dc6fe1a1-7d22-4195-ea44-665b21bf6ccf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Mar 2024 02:44:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/822663=
9608

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ebeb11fa857d


If there are some issues, you can reproduce them using the same environment=
 as
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
