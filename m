Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8809E7A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 12:33:10 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id v22-20020a056820005600b003210a0c796dso1163876oob.6
        for <mptcp@lists.linux.dev>; Mon, 07 Mar 2022 04:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GDvpY6AsbjbVQVVVJuJcJv3qhXNTZIT7WCcusUPXEls=;
        b=PgisMP1EvLPtaLCngaUbz0Fk0P87VMWWAEMiXRQMOmMHukZUAkPm2NzRA8muQHiNZb
         LFvBWgP6QYpuAMy0L4xAisbjTH+pDNRK4u0PpubuanX8to3/I6/5ud9Q1y+j27y/hw4n
         1MGJ+S0ThJZTvXLF1eklZs7aPoDN0C7yuaZPauhyXQ4IUCPXmqwP9b3RxBHvRrSfx6Cx
         s6h7nb/yI4Af1e7Auzv+d0JAk9JIImSR0DzfB2pNpBaD6pvx0hWRmC7irWCccceCE0Bw
         Je1f53De1MVrsGINh+AnImP+fg7ywLV23/gby1rMWPSohnWG1m4+9CYCRYwEsBWCLh6Z
         59Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GDvpY6AsbjbVQVVVJuJcJv3qhXNTZIT7WCcusUPXEls=;
        b=tmeqzwh9zVCrII6XvgqIV62umsLAZJXnLsMWAk6vZSfcWlUz6noUAHLAHHyAh+yjSm
         SBc+LYGxM9GK3H/9y2to8d4JHCaBT8OtxzVFRqRcNw5zB1eDFXq5QdBs2tnqjcw7VKy2
         88zAzR4PI+Vq4Euxr6IFu16JE8SsNr4/bUGtR6ZwwufOBaDTqfbulWatETNLTXyTlVWY
         qfVK5dRx4+Wg/SD9aGQUnzrD3wpy6XDP7bUqgTReni0Ucwmtld0RF6p0KuZPyTLE8qpG
         T9ffJhsontlnaXvDWSsVKV2o/uUzX7+qwfr0vGHtL8dhaKmxYqKj+oZs5Os7PxYZwBd0
         /pPw==
X-Gm-Message-State: AOAM532/nYhV6dtLAljOYksrOKVzJ1DIGWOIq3Xmvh08GSh6bUJG6jOk
	PFybslRcxXzsYCduuh2Y5aScC198xg==
X-Google-Smtp-Source: ABdhPJw0Fpa1xEZIWg6mMLHdiQYR8iSoTn2fAGN+m4u8ky5wIuqrPI1t3CFgwewzKHM4ffmJoj1K0A==
X-Received: by 2002:a05:6871:a5:b0:d4:41d7:d341 with SMTP id u37-20020a05687100a500b000d441d7d341mr14877394oaa.6.1646656388613;
        Mon, 07 Mar 2022 04:33:08 -0800 (PST)
Received: from [127.0.0.1] ([13.65.7.34])
        by smtp.gmail.com with ESMTPSA id f10-20020a4a8f4a000000b00320e5ecfecdsm1369518ool.46.2022.03.07.04.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:33:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d4b8877793e878092bd17cfd45018b0feafbace0.1646287286.git.geliang.tang@suse.com>
References:
 <d4b8877793e878092bd17cfd45018b0feafbace0.1646287286.git.geliang.tang@suse.com>
Subject: Re: mptcp: reset the subflow when MP_FAIL is lost: Tests Results
Message-ID: <514ce45f-7bf2-0302-1d87-231289af1a4e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Mar 2022 12:33:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5749632264306688
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5749632264306688/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 1 failed test(s): selftest_diag =
=F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4623732357464064
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4623732357464064/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e77e2e4ab530

Please note that despite all the efforts that have been already done to =
have a
stable tests suite when executed on a public CI like here, it is =
possible some
reported issues are not due to your modifications. Still, do =
not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (Tessares)
