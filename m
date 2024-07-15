Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C03185623
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041595; cv=none; b=rr2UdKaT+Bgky3wp/qx3D6Ka2QwSXLzpBsJ3LulyGCUtiewaNTQC8XtYA3uUFGGI5PjUI7kCzOE+xWsbJunmFQVwJKywoYZaXxbe89C1sUoLU2vlQeJSUMl59GKhAw2J7SP7YDGj52uzUNTKfFmB3VPO/eWF8D96aHS2Se4/Zbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041595; c=relaxed/simple;
	bh=LqfBT8qoFRlIJzIWm0Mlay1ldLtiJ+qZwqO/bUoJGkc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=C8Rexf2KggRkbpjT8WA3l9Fma/UqoIWRwxubeBNsMOGXtlwgCmJD2tadqYrH5HZA2KI0ZuI0MAUH0x1+XASpywTzS/X63b1YAaZ7EJcpvkVYjk9BWch2Igw2U6jOdWfkzZMVfJqyw+lQ+m5eL3Uw2xDZHEeA/8hOQqqnrBOjvEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaYZZ/Wc; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaYZZ/Wc"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d9ddfbbc58so2428426b6e.2
        for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721041593; x=1721646393; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zqLigd8QsRer6hEneQ39Q2s260VdnxxIkPROqpjoSY=;
        b=TaYZZ/WcIlxXtou6qn+hqnj3ZnLoSS3CrbTrnptnT/NtqqP87EjHFpzfejBnryw8+a
         rhbwiw7iGm3ZDQf89kD1eFznxwRQb8wIWYHQc9P0JObfcB6CnB2bfCCKVNzfnoUxj14q
         tzZgqahbCJNOfK3WmNmlAmYvYv/CfpgrSBwx9UyFvk7I7MqrjeskeQJMpFt1v14Zn2Gq
         22KNJgh8gzsQ4ZEQx6Vg7jD1UER4Fxdz2ctl99+yf5p9PGZz+6OO2XAq6KHk+oichw6l
         BejQufFu2LWt1MWtMcaEj1vGi4iJoQLf0dpl3KjKudskjevIa0OoLSKosWIlcDCKxh6h
         bhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721041593; x=1721646393;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zqLigd8QsRer6hEneQ39Q2s260VdnxxIkPROqpjoSY=;
        b=O8c/3wcevPs3ugQr7Z2f+/AoeFPqE3LQHE/+9t42MteDIk5mrOtihQl+R1aPgu60uZ
         aWjDdo9XXe65u41acW8xjw5nvN+jYq4S40aD8POCQ1Om3RJhYMDbh3uBB5ozT+7CgtKt
         CVWP59mbmwP44M1Mn0khfpN2O16b5orMv2Q+R9XTf5zmyIG11dph9MlNNQNS7scKTVTx
         we1u3gFiMR5DBiSCpy7plDjfiMmQcmp/epJVPqsHsf/7zK5HTvLpN1n8b374Qmi6jMSG
         uKH3KcQccwY/xgSH5A9wEyQn7WyUv5XQVauuXv+C4BaJt6V4TVif4koLS7rm8y1Is/vF
         MFaw==
X-Gm-Message-State: AOJu0Yymq/+n9fTveFWfmezupWwEdtIP+z2a8iJ1TrFiucbAiNRW8dOF
	78ym0cEWkRSCWtt/fQIoyDgXkT9aRK/Qaf756/wGX6kvfHUj0hQ=
X-Google-Smtp-Source: AGHT+IHI3QhefoiSd4DlujIKsj+xXz8TOFFwJSAXndWk8764wVY0rJKMxKVm+UKoeyPfKuiX07njPg==
X-Received: by 2002:a05:6808:14d2:b0:3d9:2e63:8330 with SMTP id 5614622812f47-3d93c07bb92mr24688789b6e.43.1721041592735;
        Mon, 15 Jul 2024 04:06:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.46.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbfe24sm188086885a.51.2024.07.15.04.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:06:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
Subject: Re: [PATCH mptcp-net v2 00/17] mptcp: fix endpoints with 'signal'
 and 'subflow' flags
Message-ID: <d15a0636-5951-7243-c814-f7ed21e4c209@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jul 2024 11:06:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 5 failed test(s): packetdrill_fastclose=
 packetdrill_mp_join packetdrill_mp_prio packetdrill_mp_reset =
packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: debug: Unstable: 7 =
failed test(s): packetdrill_fastclose packetdrill_fastopen =
packetdrill_mp_join packetdrill_mp_prio packetdrill_mp_reset =
packetdrill_syscalls selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/993777=
6049

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0f03b78700b6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D871305


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
