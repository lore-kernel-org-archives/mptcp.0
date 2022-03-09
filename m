Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383777E
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 11:55:18 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id x4so2400668iop.7
        for <mptcp@lists.linux.dev>; Wed, 09 Mar 2022 03:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=7xC/sP2tEQ4a8BWgX/1Gz3YmJCxXKonHAgoLOIh22wE=;
        b=A8s46fOLFBnMwihk3q8Zvh09qYkXPgV1zynNw2jqWhd2gBx8EC1A2pnWZ7p9trKEJK
         CNJxXXo46AE0dNHhgS+1UdBcXkFZfjpmYLbMB5DTIBGBp94OgELp+Rh+pekWoa7bskSC
         +BFA3Wk+f/HA5Tbtpc1RxwqCQW75jvgiUI7wS5rS0zG5Ojcya8qmgpr851pTw92O2zGU
         M5zQshBxzXIQu+dXeAAJ9LnnRZUZBLwwcP314EPryp6Ujpodi2JyUb9iXSnrJE7oqa8e
         jHzoPH6KMIxTAUkh35D8MG28wKRcJF63ab4IlvGJcUnlrGOQDvdUpSBVDZsGyXjT+xfO
         DhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=7xC/sP2tEQ4a8BWgX/1Gz3YmJCxXKonHAgoLOIh22wE=;
        b=sRoGbzWcgvoph1fCoWpqOOQM4x4w/2ZCIt/CjTQKVcCQkfUwU27XiciYh3s8H/BQ2Y
         JcZ3iR3hGpYAjhZ1uvb3jkb1O+GsbphTUPpQ9vS9jgDRhEV37W+kaeiBk2nE++CmXqKi
         9u/Kn5mXxMSzVycFN9lXPOtTh7dlzObRHDzDoi8eucRcSrAMvrt6Pzut4+TwJjHtsCkU
         JsaQDZX8RmIlgkLloVV4DH66q2ZBsrhbdoxvpsv84JRYv6rnggX4ebvoOUddSB92yNY+
         k3H/V3nPV3ifuJ/StHW7jrhwHFKjlA33ZfvhbZxeNxBYQFIEIktN7XP9ieDAryu7Uo6q
         6fiw==
X-Gm-Message-State: AOAM532k4tT2AsWOTXN/9/uyuO3n2YqPOLOqC8a9++x0QhlDVeGHGmn8
	hXa9ut7n/qapqnRew4grGg==
X-Google-Smtp-Source: ABdhPJzIIl9dbXBlajzVmGyX9tZZdbe501T3AkvY/lyV3oQYABWMY4OkQhSQfQ4WhBVoV1YxxSsYjw==
X-Received: by 2002:a02:2a8d:0:b0:314:4128:f724 with SMTP id w135-20020a022a8d000000b003144128f724mr18901060jaw.92.1646826917231;
        Wed, 09 Mar 2022 03:55:17 -0800 (PST)
Received: from [127.0.0.1] ([52.173.34.126])
        by smtp.gmail.com with ESMTPSA id l3-20020a056e020e4300b002c242b778a5sm931816ilk.74.2022.03.09.03.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:55:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <1646821209-35620-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1646821209-35620-1-git-send-email-liyonglong@chinatelecom.cn>
Subject: Re: mptcp: Fix crash due to tcp_tsorted_anchor was initialized
 before release skb: Tests Results
Message-ID: <db144358-6c4f-02e5-019c-8bc5e49c2b45@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Mar 2022 11:55:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Yonglong,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6222883100819456
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6222883100819456/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag =
selftest_mptcp_join - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/4815508217266176
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4815508217266176/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7b239139921c

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
