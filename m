Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF703205
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 15:49:08 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id c24so5133920plo.3
        for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCErpAJMKkQiXogr/6qyxH6HiQRmwHR8IlZHRtlhgjQ=;
        b=qqSdVHZFyCeSB5EpJYX++flx+AgtvfF2ABVvAwR6D3Wc5MBtino32HBdtWXfgOt+RO
         70HGrF46shf3rRPskr2LbL0pkfZQCX4HUDyiLA3zraSXp9cMLsCpr182g6ikOp88APQ/
         sBFERYhnnPmoa6frRlo6osVDoa+yYN31TwTf4ms34GAl9Q1FXBCz8wVQw3pHVNqR5IfG
         hF9wx85Yevuj7pAyCTbQ5qWMV0SF5oh2+mhSaQlSiRGyLssrFomU+LUXpctMS/uChzSP
         sTf8PoFMx+1VlD0pbR9PeOyfb+9itq2nF78XhZmKjwgbnOFThJJqjrKBSIZt5JKSlm/M
         WkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCErpAJMKkQiXogr/6qyxH6HiQRmwHR8IlZHRtlhgjQ=;
        b=Y5M6N3s1tz8m8oa51k7IwFKaoXGJLAYBghbb8LUZ9+OhQ7PqIh3u3GzfT8TgjJ0KUD
         zpUE28l62vj2jDKr4WXBUNquKYdy/33fjdjJcr77qw8vwbGKobAP3T8F2Uzwq+nmZ8oJ
         JvImXujVqBYTzwHnoKRdE76lImPoKUADOCIePrkI5XiApe2yak2b6ioWduxS8MkdKmSg
         rMpSJy497rjgbGkwpI7ZEUHnH6hohQjJOJ4mXOVvQ+BIXxK/LfSw7kCkqWBjjJpjEfQa
         YJOAPLWwApJz6uPyp8RH2zMjKLHKsNOD3U+oQ31g6Sr4qZ97mPkF0Ubn9+FcjFfUBGeV
         H8eg==
X-Gm-Message-State: ACrzQf3Y4t1Tn4DNKx7p/iIjLjg8NLfWNgw9Ro3GuKUex7FeLC5XlyQv
	CKmBvYJ5OKPwrFi0Jg+xaqr/Aape34R3
X-Google-Smtp-Source: AMsMyM5bNyZJOnq31V3e6IDhXMKwW7yRnF/rU9wvivkL9NTWvJyyiBXTUF5qhuOwnoXKk7uf+sHo2g==
X-Received: by 2002:a17:90b:224d:b0:20d:8828:3051 with SMTP id hk13-20020a17090b224d00b0020d88283051mr6336857pjb.89.1665762547653;
        Fri, 14 Oct 2022 08:49:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.253.249.161])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090a7bca00b00205fafa6768sm5151669pjl.6.2022.10.14.08.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:49:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a03e67a73655bf701cd26be3dc58480372fdf8f3.1665753926.git.geliang.tang@suse.com>
References:
 <a03e67a73655bf701cd26be3dc58480372fdf8f3.1665753926.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Frr_scheduler=22=3A_Tests_Results?=
Message-ID: <34f2b54e-218c-8705-9bc0-f2bd02b7503e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Oct 2022 15:49:06 +0000
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
  - Unstable: 1 failed test(s): =
packetdrill_add_addr =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/5124182068428800
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5124182068428800/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6250081975271424
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6250081975271424/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7d412455802e


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
