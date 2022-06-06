Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F723CB
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 11:47:17 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id x7so10130045qta.6
        for <mptcp@lists.linux.dev>; Mon, 06 Jun 2022 04:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=oryFN/TrODEBw7XcDfvoVwTLceR5UqN7Fi6LEQXyQaw=;
        b=IHkDndpcbFCH4ZDMncRg3I54Up8kvEFiD6gozq5z+UnPf5w6YdxpE6lStMD/xYISEx
         3tzR/retpPSrKgOEkLXS/ugaFbFPhVf34bU+mvvELKEH6oMomtmZy/pNRTJAfEY6Eyid
         2ZlchHIYdQ9eHit31r9wMoq0oEO3OfBfJJ5BUWYXoxZzE0x9mwEIctddjIJlITNDj5LC
         9gvd+6a2NT63rfI8S434+O3trkr+gSopDoxG8hzq/WujTojBp5u3LBFxccuBtTVZ/W+w
         4ONxWW22MOyoGByO4hWBma46iUNESrDN2O/ecW+Q0BbXph6RZPLYb4U0M322loRP5tdu
         Uo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=oryFN/TrODEBw7XcDfvoVwTLceR5UqN7Fi6LEQXyQaw=;
        b=evIyAQk8sAr7x6qBRpAp9PhRI+ddt3nK99+H5pKgdaW613BsVgZuKuijmILyh2PRnk
         02pGYIqbdH8hsCB3maXNtKrhLz9W7cVx8a/DpdqMkx8KCN3sy6oX6ft2doM7lvUV7fKP
         /sUIbR0ry75nLTvXcyv+hpcVdXwy/TBKLKgetu0DESgYTDfDLW1Grv685kiIv1ANNNAn
         B+h3KG5ZCE3dPvF4RgBD5URsegmzKDDMyRJ0yWyMZXd/rE4GKd1iS/fUhW/ijI9ziJJT
         MmniNfPrV/60cvQusIhO4imFJpqjJheiP+v1iioh7ML3AAI/LdjUenvwE+iRGfu/ddcx
         EHYA==
X-Gm-Message-State: AOAM531q7QrtyPJC8IyNvSuVMqGkGzFKzneZEPXixmESPXeRYN5cAm73
	eWlvh4+eZE0682w+FfjYOQkFbiukfUP+mBc=
X-Google-Smtp-Source: ABdhPJy99YJXdgtLDVlcgLeNHqxZIKKDXCOm4hw8c1FDW59QdN+BdwCSUK2SaQgCOtlIRFD2lL31MQ==
X-Received: by 2002:ac8:5e10:0:b0:304:bb1b:1a99 with SMTP id h16-20020ac85e10000000b00304bb1b1a99mr18065087qtx.34.1654516036149;
        Mon, 06 Jun 2022 04:47:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.12.221])
        by smtp.gmail.com with ESMTPSA id i20-20020a05620a249400b006a6ce613c7csm316242qkn.89.2022.06.06.04.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:47:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9555cebeab769c715468f99ebdbf967a715a3b59.1654508532.git.geliang.tang@suse.com>
References:
 <9555cebeab769c715468f99ebdbf967a715a3b59.1654508532.git.geliang.tang@suse.com>
Subject: Re: selftests/bpf: Add bpf_red test: Tests Results
Message-ID: <fb958d51-bcca-8f17-f153-2f8c5e347e1d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jun 2022 11:47:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6484128026591232
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6484128026591232/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 3 failed test(s):=
 selftest_diag selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4654540677971968
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4654540677971968/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3de4fe8c7ca3


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
