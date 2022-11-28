Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE99290F
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 10:09:08 +0000 (UTC)
Received: by mail-qv1-f41.google.com with SMTP id u10so1422326qvp.4
        for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 02:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+z4IjgUtgVbtaDIRH24tlWG8ZeNl/hBfOBSAGkxHnM=;
        b=GnBBa5lf9H4L33kCKQA6ix80dRkVyqnrghMsiE7s3lbnmmJAO0F0DAV54KSf2ktbsS
         ZLAnB9wlJmGMk3r4FHhRwa9jWmxg/e0WyGVvExC7xsTb4Su9o+O8wi0O+Vgpp9qEL5Aa
         cQYAR5fVmA4y5lhRKy0pd4mEcQV86tKXeBNdXmPQJq2QlMLKkj4WEAqgdXF7sv2DTe4x
         3678V9//5WG2nP/rgppmzcYf9dNfSS+FGeYDxrCjhSUbpteClOa6zZ53XncUM3CooXoc
         6zFmEZMrnZK8YBRZvA8/FEv6gs/+LjW2/xKhFGEiM9LKDDz+mvkuTNzjuLwKUwglbbCl
         ylcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+z4IjgUtgVbtaDIRH24tlWG8ZeNl/hBfOBSAGkxHnM=;
        b=LoPPLh9A5bUeq4cEmNdxy1S0xxcwz3P9VK5UahN2/9lmVtGRLe0kLce3zNXZOK3yHZ
         w3o6s5VpHQFtMmR9iyWThj/s5oASPJVg7isz5r+3m7cOnmtZGynMDWegdVRVO5FzbSZo
         Jklnwh0Hxw3fKQH1ARP0wasKeGbLRTBAbb3BKV27MIJzknAGjTqs6gqeQOmgy1jBYH7d
         N2ZrFuoNVifOOvU0j/vbCN9o6MBL5C0neQ1iaAfhKIMlVp3ZDtB/oComzGxF2tv4c8jb
         mUlfMx1sb9x/jWqKPa73sdWyqJ6PdhAMRXV6admf6+A7Ak+2cHRmz/GAqLDULdagdfeK
         D4GA==
X-Gm-Message-State: ANoB5pmFRzvbND9PZ6P8vbJneseLQzKA/cGysycl0stP16PiL251rc7U
	4nKz7tZ86uXXXnirINIcyc0N52v2BxXl7kw=
X-Google-Smtp-Source: AA0mqf4doZFAK18ZMG0MG5XEtmuST+dLcmXa92eijGBTvaeWOo4ak8CgPVP9X2mAaTODrxN9LzRekg==
X-Received: by 2002:ad4:43eb:0:b0:4bb:7ad8:deae with SMTP id f11-20020ad443eb000000b004bb7ad8deaemr30256006qvu.92.1669630147852;
        Mon, 28 Nov 2022 02:09:07 -0800 (PST)
Received: from [127.0.0.1] ([172.176.218.25])
        by smtp.gmail.com with ESMTPSA id bk11-20020a05620a1a0b00b006fbdb9d04b1sm8078038qkb.40.2022.11.28.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:09:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ce000e27b0b132ca060b08db392c0ed5ddc39139.1669383374.git.geliang.tang@suse.com>
References:
 <ce000e27b0b132ca060b08db392c0ed5ddc39139.1669383374.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_listener_test_for_in-kernel_PM=22=3A_Te?=
 =?UTF-8?Q?sts_Results?=
Message-ID: <50aefb93-7bd2-b85f-1cb2-5062b5df979c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Nov 2022 10:09:06 +0000
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
  - Critical: Global Timeout =E2=9D=8C:
  - Task: https://cirrus-ci.com/task/5572756239024128
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5572756239024128/su=
mmary/summary.txt

- KVM Validation: debug:
  - Critical: Global Timeout =
=E2=9D=8C:
  - Task: https://cirrus-ci.com/task/6698656145866752
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6698656145866752/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3855a99bfac5


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts =
(Tessares)
