Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEE19BAE
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 17:18:30 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-31114b46d62so6417580f8f.3
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687367908; x=1689959908;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=taLx4JvCTrD93c/8Bm6Zbo+i5BZv0BdEDkN/dlQ6PiI=;
        b=orowwwrBvwysjwlewNMn8KxjXqwvXG5RVqMqq8uV6U5UR4PO6IAD240HhCNIjlOpG1
         7YcsJU/RmHEsF2IWy8SXOJnl8SdHe+Hm8QrvEAxrPWs8+PAAAKVletBdDxGSvh6eLKIt
         118SToWUDXDGdtN6xkrqRHQh22dI4Vt67j755sD1tbF8jXRQ2rtzNIGeTd+yUqqNygyB
         zsnj32pCuxF5Qa5gt+Tlr1zzxrUK/2jouRj8G5VVlP2iABwcGPftXlipnEG/XuHFH9JM
         euPp2Jj7uhc0vr7wm04YDNLa9eSrRWfPHEQB/tpbCi/de4Tv1tw/WAku4sDql5CX0Huy
         m34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687367908; x=1689959908;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taLx4JvCTrD93c/8Bm6Zbo+i5BZv0BdEDkN/dlQ6PiI=;
        b=LVdiG3VQjcT9RPuTIMvQ/gShl5Ks2b60Yqn3d2Ym+XNRxDYq/losmQyDiUBHsqq9IJ
         To7Y2AGPOeoMiJdMfb4ymEBEPZRmfujxmWjGuroBRpjwkSXFuvuo/tX6ravZUW1FI6Fv
         khXMEmrLvStj5bUVyn75ZQQqRDL6n2j8c69HCYqVvv04hfDJ8dOy91KsweUhuuX5DHjE
         OdxG7chC1yzp5V740xvE4k4PmDCsAiuPo3sJmI2fSWJI9o0COXO3JB+EhomJn4sJdV2P
         CLD2yazWgtdm1aVoqU2A0UD/qggnr2kxGi2CpfB1Y63uVZIBJ20erdoSE2kXmxA7asOj
         Di9A==
X-Gm-Message-State: AC+VfDwE2B8LZEYShxj0NtzK4m33q0aIUhrHY/rTpS/wCEG5TWzlqQe5
	QqT0ZTeR6Y/2Kh34oXiFS6WEc57odfbd/z/fRxrB8zzt
X-Google-Smtp-Source: ACHHUZ48Gyv000jdzwXmhu9kEwNzypnuD5ifLAHiCJie6UPWgCRxd03qQfPE/gQ+vpBZNG+NLZaGBQ==
X-Received: by 2002:adf:e447:0:b0:307:cb94:85de with SMTP id t7-20020adfe447000000b00307cb9485demr15167498wrm.11.1687367908501;
        Wed, 21 Jun 2023 10:18:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f1-20020adfdb41000000b0030ae499da59sm4930027wrj.111.2023.06.21.10.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 10:18:28 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 00/18] selftests: mptcp: format subtests results
 in TAP
Date: Wed, 21 Jun 2023 19:18:01 +0200
Message-Id: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkwk2QC/yWOQQqDMBBFryKz7lBNSqi9SnERk7EGahoykyKId
 2+su//48HgbMOVADI9mg0zfwOETK3SXBtxs44sw+MqgWqVbozpckriEgbkQanNHpvckxMLIZTy
 Hdqq35tZ75z1U0WiZcMw2uvlQybUklkx2Oc6UaQrrv+AJpzzSKjDs+w94Ms1EnQAAAA==
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=c5VPi/V1ppondQg9ogmHWCGPCHc3ot99Xm+oLHIs+vk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkzDi+Jhkn3GdRxTwloEE1/1oMHWRd/Xv1H2Hh
 c7RO/LYO1CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJMw4gAKCRD2t4JPQmmg
 c5WqEADO0cT1IebDBxuxYqk4A5RPuhGbWf28KlHiUSmBciVSh7hnZT3CPrtyyVZ01g1sVb27nCy
 ro0Vtlp9jGsteXkD7llrflP2qQXTsYXFv7bKOUhaFt3uo8VTjOLBgwmR3hsxxwLAc9rJdYolQLq
 /PzA8PrfRqnT5i4/UN1iFXZyzJcyr91JHWRVoFqprPgaHWdJiyK2IPgyV7AD9IMSDJ09449ksyb
 j8/NGZDsFFx1jGr7LTeuLx17LZoMgtgcwkDAgh4BnzOIt5qBvNEqt4D7gQShJDmSCP+rvjAfyjM
 eF5DiOgrmq10LaHhhhOLUwRIUay7+DoedkYwaGvF6fvvHbmrfxywO6LWW4y+d6xnqum+2Uag//F
 0j+MmonS2Wb08ILqgfD0a2ZGaU2YOfwqZkqopH+Iyq5uvCTKMezWafxy22l0kuvgnzkA+pTDQS5
 ZTUTdPL9SHK6bSvLSNDpvI1hrf2XmC96UvFtBrW24P8VRX5OHnXOUzGzxvXGQcaR3jtRxZHla9T
 P80U6Tn8gbnvQ/duKnbqt4ZLnazl5dj7CuK1J+WSV71jC5FGs9VEycvkWzFEz8ouuD1tqUcStN2
 uwC7dyDF44lhwWP0fRLkYbQQ4Mk2I4SkQwvtDje4vQLhkr4J9L9Xouycq/B4khZfb06ufb6oKE0
 hLpyBgVSNFteheg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CI executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

Regarding this patch set, the 5 first patches are fixes for -net:
 - connect: issues with nft were not reported and then ignored by the CI
 - sockopt: issues with packet marks were also not reported and ignored
 - userspace_pm: similar fix for "remove" tests + use correct var

Then some various improvements for net-next:
 - connect & userspace_pm: continue executing tests if there is an error
 - userspace_pm: some refactoring to reduce duplicated code and prepare
   subtests' support.

And finally we have one commit adding helpers to support subtests
followed by commits in the different selftests to support this feature.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (18):
      selftests: mptcp: connect: fail if nft supposed to work
      selftests: mptcp: sockopt: use 'iptables-legacy' if available
      selftests: mptcp: sockopt: return error if wrong mark
      selftests: mptcp: userspace_pm: use correct server port
      selftests: mptcp: userspace_pm: report errors with 'remove' tests
      selftests: mptcp: connect: don't stop if error
      selftests: mptcp: userspace pm: don't stop if error
      selftests: mptcp: userspace_pm: fix shellcheck warnings
      selftests: mptcp: userspace_pm: uniform results printing
      selftests: mptcp: userspace_pm: reduce dup code around printf
      selftests: mptcp: lib: format subtests results in TAP
      selftests: mptcp: connect: format subtests results in TAP
      selftests: mptcp: pm_netlink: format subtests results in TAP
      selftests: mptcp: join: format subtests results in TAP
      selftests: mptcp: diag: format subtests results in TAP
      selftests: mptcp: simult flows: format subtests results in TAP
      selftests: mptcp: sockopt: format subtests results in TAP
      selftests: mptcp: userspace_pm: format subtests results in TAP

 tools/testing/selftests/net/mptcp/diag.sh          |   7 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  69 ++++++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  41 ++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  66 ++++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  49 ++++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh    |   6 +-
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   4 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 181 +++++++++++++--------
 8 files changed, 319 insertions(+), 104 deletions(-)
---
base-commit: 9b5467a5f7f3f8c37c9fd84acaac3d4a5e2c64c4
change-id: 20230621-mptcp-issue-368-selftests-subtests-3c29a649dcdd

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

