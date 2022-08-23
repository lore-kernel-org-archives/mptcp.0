Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B42589
	for <mptcp@lists.linux.dev>; Tue, 23 Aug 2022 14:51:55 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id cr9so10497802qtb.13
        for <mptcp@lists.linux.dev>; Tue, 23 Aug 2022 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc;
        bh=k9Ytfvr34wvAmNZ6zgOqFfjhbt715/rhh0LsDstNKzM=;
        b=ikB982tnHSAkUoQrH8KkBqfikayHpO1btR2WU2PDRqNssdcSMmHeIj09Vx/JEokHx0
         3hvXEbZMBsG1hWS96aFCsWr8RM1Rv/AatYAEOitV8buVqXhxWmS7Y0gvZCzwWSzvjCoz
         9RN3xAvF7nxKZjEkhDHngYalvykw4AqteLQIVoZK/DV9bvlUMErvJu3NPiJSxeeOyslT
         1i/LeXe4Cwwbh1x1vmOTsxrB6TMcw0PGGesqdJcAvKctg9B6oKnF0VtYcsVeiUnSgUEd
         KCEnrckFEKr9jQXFZFpDQFkSfje10w/LR53pHDuHjgLhPJ2nExkImMU4ujN0Cb7W0pp1
         Lcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc;
        bh=k9Ytfvr34wvAmNZ6zgOqFfjhbt715/rhh0LsDstNKzM=;
        b=Nlz1rUq+tp7WbjsLygRbxbkOSxdE1jChSkzUJYdoso8nKkyw39zNMYKEZizkXi3uef
         DIqRH+15gIffaY5lnWi7U98BDBhpiWfEEpUppE4zjQQqZHUuntE+9/7LpqDXCtPCX2J4
         f0I6NzgKyeg0Gfi1yW4kV6szMAPBm+ZesKBefRL9O/vMLqWPg1RasqHtWGLol6R5wwAd
         VHDayM5ElM7TdCRZmyl1TbYDk5BjvpbB4+wP4Nlnmj9kkIw4v5hBWxySUItl4NZ32Ig6
         /YRry+4vCmsPlmvKsseVcUfywwourA8tq8hcuvkOyjrC8Snne3zoQg30x4lx0xPWw4Qh
         oquw==
X-Gm-Message-State: ACgBeo3NvTHVve2MiWTRMIMmehKfuniyYC/y6zLTxRyGO/mSgdwtNE8j
	2cPGBBcw0pf9y8IX9yBEoQ==
X-Google-Smtp-Source: AA6agR6K3f04061NNBaEIx/wNKaz6YYnmlUv8SDQlIqmtfiXAptFrqkYJbe5mdcm4JIwvOSVOnI+MQ==
X-Received: by 2002:ac8:7e81:0:b0:344:95a5:75a0 with SMTP id w1-20020ac87e81000000b0034495a575a0mr17604761qtj.128.1661266314333;
        Tue, 23 Aug 2022 07:51:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.82.19.133])
        by smtp.gmail.com with ESMTPSA id s3-20020a05620a0bc300b006b59f02224asm13113909qki.60.2022.08.23.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:51:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <95f0f96d90264cc6411b024753fe8430f6998e4f.1661258990.git.geliang.tang@suse.com>
References:
 <95f0f96d90264cc6411b024753fe8430f6998e4f.1661258990.git.geliang.tang@suse.com>
Subject: Re: mptcp: add do_check_data_fin to replace copied: Tests Results
Message-ID: <b69d3d87-2dfd-5b0a-a9cb-ac0c770e9365@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Aug 2022 14:51:53 +0000
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
  - Unstable: 2 failed test(s): =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4966947568746496
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4966947568746496/su=
mmary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s):=
 packetdrill_mp_join packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6092847475589120
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6092847475589120/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/90bc7455e572


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
