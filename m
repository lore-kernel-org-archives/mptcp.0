Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691381C29
	for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 10:48:01 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2450888wmb.0
        for <mptcp@lists.linux.dev>; Wed, 25 Jan 2023 02:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm7cAXvuksIT8Vn2KQfM6U5yXB3a8DRF5yFqF7/IqD8=;
        b=1DG9Q4JaxhWmDSfrx9wk2S4ODUu5D6gqvoB6VO/OCaz2SOQSO3tjWY73kamLORPcBs
         56QmJF4rzK2p74s4oX2uBD3waQUQ53Kixs4jk1ALWv+c5d9BHhh0ftllxk9dMguVzn5a
         B5XjxReIgyKyP0kQqfsJmKpnv49gQLWO/JicjGLQVJHavsgprJs7AW+l5VE1/9EJatep
         88ftE+66RVdR4tra/hy7oWcjZijq5eln7VYfBbp5GVADqPcnwu85xD5UsnbvBdbBGtHQ
         EZtRJsFpD9FgH2TxCxiufaMmnJkqbY8ybwCJlDoi6g4v1rATIQkY/un3sGjVCBd9vFiu
         DeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sm7cAXvuksIT8Vn2KQfM6U5yXB3a8DRF5yFqF7/IqD8=;
        b=iei85iqZFWlB02qPuVhfPVTSkHjBSk+rzDcOz9tPe8LToWV0pk3NMNOCIcV2cqEXUM
         ZF+S0424VQklGY7d94ybdsvg2OhPsyNbsdqYOnK8LT+NAo+j/UHMs8Qsm2s45h+wglvj
         lrMxOqARd32AOoRRU9/6YX02SgYHMYkO4AFT3O/ZT3OFDABsMcu/kw8ODr5IdHIgMTwv
         360vD3+3IPZFiOYBJ6GjYOztYXrkWTWRMZyOFCBt3+BQ7wUE4WU0NnRpNCX5r9hjnHIp
         OgB7E+WdST+0TbmhaiL5r8i/vI73x0yqoOK6mbMTO49EufOof2wWI5OFgth5MTwH1hGz
         QPWQ==
X-Gm-Message-State: AFqh2ko+/LF9migWlGUdIiZuC14YW+TuaBGzpephKBzsxL8C+93liU9v
	8DxC15y+1aZmh6lFBPVcm/+ZgA==
X-Google-Smtp-Source: AMrXdXsG9G6gXlDwKCzRzfrFFehM2xBbZSrI5a0qX8I0kxu8fudTbJrBiiil6k+s843f+kkQHh9C+g==
X-Received: by 2002:a05:600c:a15:b0:3db:18a0:310f with SMTP id z21-20020a05600c0a1500b003db18a0310fmr25637661wmp.33.1674643679225;
        Wed, 25 Jan 2023 02:47:59 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c424100b003d9a86a13bfsm1423692wmm.28.2023.01.25.02.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 02:47:58 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/8] mptcp: add mixed v4/v6 support for the
 in-kernel PM
Date: Wed, 25 Jan 2023 11:47:20 +0100
Message-Id: <20230123-upstream-net-next-pm-v4-v6-v1-0-43fac502bfbf@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALgI0WMC/0WNwQqDMBBEf0X23IUkBpH+SulhY7d1D6ZhkwZB/
 HdjofQwh8cwbzbIrMIZrt0GylWyvGMDe+lgmim+GOXRGJxxvbGux0/KRZkWjFxa1oJpweqxDhj
 sOPjRkg/GQBMEyoxBKU7zqfgNziopP2X9/t7+xX3fDwd82FWRAAAA
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=y7xt/jDxFXcJ15EgIkD8oBTqZDL9ojRU13M9eMUQTFQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj0QjdXadWm/alm36siF313JgJqm+QfrUf00BHhUMv
 Oqy+kBeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY9EI3QAKCRD2t4JPQmmgc7g9D/
 49zFh8NUIeA1NRsjrUD0s0nvcXhkcm1uDs+xlatBCfkwwhyLVci2wWXKq9rEzynsV6Ff+IQe70UXwZ
 Bega11YJTkt84+t1DJCbQ8RW6m79vF3dETy7Huuv6yfSZjgtbaiv1rS/7Qy0dQSKkH3MOoHBSau9Gd
 CIx4MIY6OYi3Q2mn4wociPth1irrJ1bnU7YqWt9qtu1f3G8EaEPiBfYki7X6JPqi6dmJylb0Li5PZS
 /p2jUczI7ctJDWCGU3JTn42cgk5O6aKi5zqEKm2p6uLxdFhhd8x/Z36yLChfdO8dn5t28JHFqA5Z7K
 V4ybZ2x4yflm+GilYKxrnP9pn7ryn47k9Cumg2GPG7jT4E5LeEhvFIDjjFEMIDeFtVBdRi6VB3syG9
 hS4Ig5Us92VM82fFDxav6yMOsqzppwe45+oC/j7nOTDcESeGaWY4w3LUOAnUxYC77peICUM3p3wcyn
 z2oWhpcgsNmF79QnfONrsxeEDSBVNoqZWMLmYlldc8MmTrmjMCxmOyxu9NGyN+l3WjR6mA+wJ5F1Sy
 cEeqBi6wXxuOrFbCjgJcu4+IFY0XC8GlJAViBH1rF9rYocoR+VwF4HoHLoZm6FXYmxFIWU8gDImogL
 CB/IGVehkyu/rQwkYp45hdw3OUoZpa/yyVhNpIpWUIHLsvwPnQX+Hk4Dp+3w==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before these patches, the in-kernel Path-Manager would not allow, for
the same MPTCP connection, having a mix of subflows in v4 and v6.

MPTCP's RFC 8684 doesn't forbid that and it is even recommended to do so
as the path in v4 and v6 are likely different. Some networks are also
v4 or v6 only, we cannot assume they all have both v4 and v6 support.

Patch 1 then removes this artificial constraint in the in-kernel PM
currently enforcing there are no mixed subflows in place, either in
address announcement or in subflow creation areas.

Patch 2 makes sure the sk_ipv6only attribute is also propagated to
subflows, just in case a new PM wouldn't respect it.

Some selftests have also been added for the in-kernel PM (patch 3).

Patches 4 to 8 are just some cleanups and small improvements in the
printed messages in the userspace PM. It is not linked to the rest but
identified when working on a related patch modifying this selftest,
already in -net:

  commit 4656d72c1efa ("selftests: mptcp: userspace: validate v4-v6 subflows mix")

---
Matthieu Baerts (6):
      mptcp: propagate sk_ipv6only to subflows
      mptcp: userspace pm: use a single point of exit
      selftests: mptcp: userspace: print titles
      selftests: mptcp: userspace: refactor asserts
      selftests: mptcp: userspace: print error details if any
      selftests: mptcp: userspace: avoid read errors

Paolo Abeni (2):
      mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses
      selftests: mptcp: add test-cases for mixed v4/v6 subflows

 net/mptcp/pm_netlink.c                            |  58 ++++----
 net/mptcp/pm_userspace.c                          |   5 +-
 net/mptcp/sockopt.c                               |   1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  53 ++++++--
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 153 +++++++++++++---------
 5 files changed, 171 insertions(+), 99 deletions(-)
---
base-commit: 4373a023e0388fc19e27d37f61401bce6ff4c9d7
change-id: 20230123-upstream-net-next-pm-v4-v6-b186481a4b00

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

