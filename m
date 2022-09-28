Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553657B
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 11:13:40 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id iw17so11541675plb.0
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date;
        bh=+APSNAYrwhg4xLtHR74ultOZ1rd1BXer+2Ot75Q5rpw=;
        b=CZIZPzVDrTx1BEpdydE9Q5lD8zbEq4vz2RZAxxf5fOECY9oltQKIJzrybbWUkcdRGs
         WX8A+hDNhxWBCee984dyNtRwY1MH8DUCUAilt5vAcuBwvc+cz8AhBYOpE//s8GDNS4ig
         BOi258j94udy0R+4C7NgiCL+ix4y+IWtaqd0zRcT2H+IqMv6NLqB5yKxR59KOQAXiPxd
         YWEuDUdkG62KmdzrWOnJ4fassa9jIo+jfG0mllQfZ4RRSReGtXtza584exYrO66Afq3U
         fgGiCTTGGAcMxX0Ctl/4zAshD/F4U/ZH03F8CrA++uEGTLi+cY3OGGnggrIkbxRNEBAV
         Fz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date;
        bh=+APSNAYrwhg4xLtHR74ultOZ1rd1BXer+2Ot75Q5rpw=;
        b=BYnpsHSMzCAajXRMwwushoqyl6X2yIEwtkA6S1F9Hsj2k2rfvXbTV0qnd+EysQY5Vx
         sKKiFzUE4e96s+TRxQSPTpgvgWbi420b2qIoaPsTe9OdLNjriiLM0uZulqfTF1kXXugd
         HcpGfoOTvPngh04/mei/GQNiQ29tWNrnrUzGHM6ErrSij/xu0sasoNlf9Tk7GMr8fcmb
         IGNKh6aqmY4FccsZPeGtVCy3Zuiuy24euZz1PttSD6eBdyYbhBox7uDz6cyR7TdgG/cP
         O1IrnX99Px1Q7tEGL227ben/RxJ6etXT7VM1fOxOcjv0LA0qeLCOSjhudisGTfkns25x
         yPGw==
X-Gm-Message-State: ACrzQf0U8k0803qoKcQiz2WUqKpD+ACrhPiQ4DrC74uMyCeRV14qFoZE
	IadjXti7JiTIReRB8MRelqZqqGeFcJ+4
X-Google-Smtp-Source: AMsMyM59/i1CG3IZ+fKLBrHNtUzfsEjBuAqYvkiHLyCGTs9MrQ9Ddz2P45lo4LN5yIPOo49kDU99rw==
X-Received: by 2002:a17:902:f70e:b0:178:8895:d1fb with SMTP id h14-20020a170902f70e00b001788895d1fbmr31854190plo.166.1664363619576;
        Wed, 28 Sep 2022 04:13:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.237.252.136])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902ecc100b0016be596c8afsm3444254plh.282.2022.09.28.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:13:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
References: <20220928091852.1933333-1-matthieu.baerts@tessares.net>
Subject: Re: mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT: Tests
 Results
Message-ID: <f4b30b1b-2153-a193-ded0-a53291e486bd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Sep 2022 11:13:37 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4607251246743552
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4607251246743552/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5733151153586176
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5733151153586176/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3d4592725a0d


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts (Tessares)
