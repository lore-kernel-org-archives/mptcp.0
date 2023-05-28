Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FC52109
	for <mptcp@lists.linux.dev>; Sun, 28 May 2023 17:36:04 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso18154895e9.1
        for <mptcp@lists.linux.dev>; Sun, 28 May 2023 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685295362; x=1687887362;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VgPDfFpDepN09tAvzxisbxa58llXbpe18nSgqJnJRjU=;
        b=rgj5G2s+N52emvHq9W1ntw8O5uPxq+pFx+5FwzcifTQGSiHAVomnhwVHf1nnidWt6q
         NrIujJh8uDAKJiVEE2AO+RaCfhYUiVuG0bcdG8m17Zt7PxdybGrfmJRSr/bJcL9zIB3t
         bALRae5eRglG6ztQSpzYuISK6BCpS0ttutLSZenNkgg56GBcfDlsFeO0bOBrIVIG29W0
         oFD5E1UKAIS6mRSN9YmJenVDqSCujgfmoCF52NYyyOfHDs4CYcbxG77k8++6omrvvUNu
         xBWCslqPWucSlU2a0ghvYOqCiF3LeEISxTb6aUughSQlgc2OQvWsKVK1ZPP23IEUHdZQ
         EyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685295362; x=1687887362;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgPDfFpDepN09tAvzxisbxa58llXbpe18nSgqJnJRjU=;
        b=f6YJuxrYmoR+dY0pYwQq/V8W0OQULRPXgP9vN/iI5lGrjpqspbTaX66BjWVfxL9VUP
         c8tFHp16DPbtioH1gB7LWMxGn954B+RPwAnbNLWUVi6ayW18Wka4+go+JKhj+5yBoAnF
         3SglXsN7IYe3dUED//9pVBtbXxUosHdtxNC7Ek29Ti2XpuyaexLbyYYo5L2wjYPw5zh+
         VNowkEwnwSljHN295/p4LS872OREMHZJRP1jFSv9joluU/U+ejJqCXh7bcW7GUjOCl5q
         9BFUPMPOvhh6R96OQEDk8x4Mh4DFK97ITLg90xn31D+w6125ZfGlUNK3vctaPn/1Y012
         K/ig==
X-Gm-Message-State: AC+VfDwQPti365Hcf3lur5kVeOOIvY/gsRV/G2ywozRtejPY1zSGz2I8
	rz4DCbd2DhJ5UN/pJszAisPv1Q==
X-Google-Smtp-Source: ACHHUZ5z6UUO9qErx7rddM51YnwXRZiYQBfzXxkC1QPVxR3oFA3IrRiJbAnW7uzu+eZzQY+dbKlJ4Q==
X-Received: by 2002:a7b:ca42:0:b0:3f6:8ba:6ea2 with SMTP id m2-20020a7bca42000000b003f608ba6ea2mr4894454wml.15.1685295362339;
        Sun, 28 May 2023 10:36:02 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z10-20020a7bc7ca000000b003f602e2b653sm15334523wmk.28.2023.05.28.10.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 10:36:02 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/8] selftests: mptcp: skip tests not supported by old
 kernels (part 1)
Date: Sun, 28 May 2023 19:35:25 +0200
Message-Id: <20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-v1-0-a32d85577fc6@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6Qc2QC/z2O0QqCQBBFf0XmuSFdK6RfiR7WdcwlXYeZMQLx3
 1uDerzncjl3BSWJpHAtVhB6RY1zyqE6FBAGnx6EscsZXOnq8uwaXFhNyE+YyPBPJ7bAqDT2Rmq
 KujDPYjiPHT5JEo2K7DOoMA8uddOfujaUkDWtV8JWfArDLrLjz7CXLNTH9/ffDbIR7tv2ATEX4
 d20AAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Christoph Paasch <cpaasch@apple.com>, 
 Florian Westphal <fw@strlen.de>, Davide Caratti <dcaratti@redhat.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=75HYeXxG55KPo56OT1QMXARO4lwKjONuoUweD6PxHRY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkc5EA0+GzNb8nihOX2uRnYncESRC+xg4pKxRCH
 3sJCo5oNgiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHORAAAKCRD2t4JPQmmg
 c/j5D/sH3eiNSTv3LwOpchmkjY6MqFbvbi6mOgFz//+ZA0bTiNqOHHdCPpT54xqZaA3w79kikmr
 A3Nn57sA4oAQNkhsrDKLIhZ74yita2bAjZTAa9xsO9BcIrTv2K59oz+2g/tydCEetWEp77iQsF1
 qF8S8+OVYuKBsU8VtXf+Or49hbqu6RwzbE2VdMGy0OZjm4ZAJFWN0mmUTI0BeblLUrJYdFVfidQ
 IhVhot7uV/NMKB/ih5GxWEXkll5zmLlkD976ykMnsOkWZDsupmnCXujpoKSKwjnAexP1nNZvuRP
 xQJ00+M7iSNgzmMVWQT4LBqGs+eQ6McrpHVLKeoQea+bcCuaUJ9O/+DY/JIDH3zlVDV2ce0yNrc
 lqyurAfO1rrs6HCOt4oJbF+dZLE81nHck5wgCh6txZwx3Ho7AwK61Yz9h5WU+n5k76dK1gVHd+I
 gZykh5/XdL/vs2PoQa2IzWALvXThrdaVmT8iaaKSVWnlB7nBE0nR4uK6DzyfGKnu09vFBL1UZU2
 LnJBV+pDuMkBZ8/MKofyiF4H6mtwBGthu/qX0b0Ws2YQnh1iVlR1txdAv5ulwbseJVWSb/7xF4N
 2h3Qm7xQFoUfJRE7UJC0QiGlwrGyoDugRPS+fihDgB4RraM4Cl9BykS+bvq77erhoyzGZ5D9liD
 c7IFbmwDq/IFJjw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a few years of increasing test coverage in the MPTCP selftests, we
realised [1] the last version of the selftests is supposed to run on old
kernels without issues.

Supporting older versions is not that easy for this MPTCP case: these
selftests are often validating the internals by checking packets that
are exchanged, when some MIB counters are incremented after some
actions, how connections are getting opened and closed in some cases,
etc. In other words, it is not limited to the socket interface between
the userspace and the kernelspace. In addition, the current selftests
run a lot of different sub-tests but the TAP13 protocol used in the
selftests don't support sub-tests: in other words, one failure in
sub-tests implies that the whole selftest is seen as failed at the end
because sub-tests are not tracked. It is then important to skip
sub-tests not supported by old kernels.

To minimise the modifications and reduce the complexity to support old
versions, the idea is to look at external signs and skip the whole
selftests or just some sub-tests before starting them.

This first part focuses on marking the different selftests as skipped
if MPTCP is not even supported. That's what is done in patches 2 to 8.
Patch 2/8 introduces a new file (mptcp_lib.sh) to be able to re-use some
helpers in the different selftests. The first MPTCP selftest has been
introduced in v5.6.

Patch 1/8 is a bit different but still linked: it modifies mptcp_join.sh
selftest not to use 'cmp --bytes' which is not supported by the BusyBox
implementation. It is apparently quite common to use BusyBox in CI
environments. This tool is needed for a subtest introduced in v6.1.

Link: https://lore.kernel.org/stable/CA+G9fYtDGpgT4dckXD-y-N92nqUxuvue_7AtDdBcHrbOMsDZLg@mail.gmail.com/ [1]
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (8):
      selftests: mptcp: join: avoid using 'cmp --bytes'
      selftests: mptcp: connect: skip if MPTCP is not supported
      selftests: mptcp: pm nl: skip if MPTCP is not supported
      selftests: mptcp: join: skip if MPTCP is not supported
      selftests: mptcp: diag: skip if MPTCP is not supported
      selftests: mptcp: simult flows: skip if MPTCP is not supported
      selftests: mptcp: sockopt: skip if MPTCP is not supported
      selftests: mptcp: userspace pm: skip if MPTCP is not supported

 tools/testing/selftests/net/mptcp/Makefile         |  2 +-
 tools/testing/selftests/net/mptcp/diag.sh          |  4 +++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  4 +++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 17 +++++++--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 40 ++++++++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  4 +++
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |  4 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  4 +++
 tools/testing/selftests/net/mptcp/userspace_pm.sh  |  4 +++
 9 files changed, 80 insertions(+), 3 deletions(-)
---
base-commit: 9b9e46aa07273ceb96866b2e812b46f1ee0b8d2f
change-id: 20230528-upstream-net-20230528-mptcp-selftests-support-old-kernels-part-1-305638f4dbc0

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

