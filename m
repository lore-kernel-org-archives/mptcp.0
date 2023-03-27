Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F440A29
	for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 10:24:15 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so1588287wmo.4
        for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 03:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679912654;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nwOigjhn0/nfkRIj9IqWCI0UBahJ590Lb8WM7IjXdAg=;
        b=Xc+/9HD7Op2pUmUWyNmJKebsfr0V6V4TKAwRPQHLAeRro7SpW5jx05OjR5FdG8kRjw
         iIveblhWJ+itaepVyxm8MgQ7RopOA2sUUSFfKYzcyOvb3QMC3xnmmrnYSAguvlREtM/Y
         KPFRZFYN+stCmAKR4PV4gymb8CWHzwZkoIcWupam/J8tdmxPnJz9S9OquBMELkSutwDd
         JbI1/E08wCj4FSBDa/9S3a+3dM6ZsJ6DFQCOj3Jl7Wl1aPEUNjLK9FORGkt5+qD4h04N
         v3GAYm+l8/Y+ELBMKNaaFSwPCG+soviFpRQyrNiMqRlhisJo+H8KxPp/jsatG9kSHw7R
         zkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912654;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwOigjhn0/nfkRIj9IqWCI0UBahJ590Lb8WM7IjXdAg=;
        b=kjptVS1uq4BMxBvrxUqsfaF7A05298gopeotu7UajYN5Dfwg0upiau/saFFtM7UN0/
         Gh0p8MfNwHxire8bIVshwOuLUcZDok8NO97uG0ROW2ZGiPDa1ez2lCSFzcgPwXtYuUwX
         x+fLxWpa5K7+fKpRheQo36f+dvvb94vbFQNerARgdH/95tbplcONHEvLi5dH4MR1xhoY
         zplKK/+Sn+899TH1eSCqRonDghK3KLIIMC7NN1HLD13LVuC6XBXTQH1XG8ditlxfIIfE
         CkWvIMvNMGqpU3pIrAiyHAzVIUzUgpnBYBD3O/GKaBOdXcA8SfW97HA3PD3PxndWAY7o
         DE/g==
X-Gm-Message-State: AO0yUKUUTcesgYXSVgP9DJd3IXUwrWa6yYiSMUyBib1mHsXWYJEAqmUX
	c+iWpKsxxR1QsRMaRxkqpx4gfg==
X-Google-Smtp-Source: AK7set898rOJQM5FW7BmbcFoKGsUFxXHG4duGjk1byMM9H0yiU52gRKBRI8gPGwbgMlkX2IDnaPsEg==
X-Received: by 2002:a7b:c39a:0:b0:3ed:9ce3:4a39 with SMTP id s26-20020a7bc39a000000b003ed9ce34a39mr9370389wmj.26.1679912654170;
        Mon, 27 Mar 2023 03:24:14 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003ef6f87118dsm2220615wmq.42.2023.03.27.03.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:24:13 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next v2 0/4] mptcp: a couple of cleanups and
 improvements
Date: Mon, 27 Mar 2023 12:22:20 +0200
Message-Id: <20230324-upstream-net-next-20230324-misc-features-v2-0-fca1471efbaa@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFxuIWQC/5WOMQ6DMAxFr4I81xUJoYVOvUfFkIApGQgoDogKc
 fcGBpZOHTx8ve+nvwKTt8TwSFbwNFu2g4tBXhKoO+3ehLaJGWQqszSTCqeRgyfdo6MQbwl4ot5
 yjS3pMHliFPfCSHMThRIKos5oJjReu7rbhT+evTN6au1yzHnBCapIOsth8J9j5ywO/v+kWWCKu
 ZalyFVeStM8AzHriK7xFapt277421BPEQEAAA==
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=YZ7HyQPpwwhOjk8ddV6pgNaqf8NyURsDaIfJoPwcGfY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkIW7NnZNWfPoVEFzjURT49Y1TSl9DYozAFxYOd
 vZ+XAOPUeWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCFuzQAKCRD2t4JPQmmg
 c1kxD/4rQHDzB1swzhIlOTM2X1tysCsa0SaRMfBsABnVupqCeRq0kCcPvKrvxHGRCZDOj21yncl
 RX+x906PnQHRKpbUxhB2oB+5AQyYil+4sODn9F3ZxGEY85QpxSvRiSiK2MgH9itn+y865r7oKio
 vg/1sC00WnWFXzUkHwe8sQzFUxComYs5B7HHfg9hQmMC23c3Ec4fxjTkNRH1xWE6AXk0ckJ+4Sn
 te3cm9VddP527c1BAJsrZnT0b21NAGh+4DadZ2T6JVQKO2OLJm7wcH6OJmD2HFphBhbC5HLnih+
 ygpIun9Y4ZQIqI7A/avvLrUWfXMjskQT83UHqBn9kleJUwqvf0tJqE3fOCTLZY+0GPmoHzrm/tt
 nEVwUu7zkn+lzBzkEqf0Q9DKcB+oFUT+f8G3ylQIyNG0WXcNp9zA/zWNeaA8hk7HUyV4cvGbL0E
 Ajiic7nZv6rZ64B7VUz6619B3Emsp5S8bm69NRhMpAuvAyQARKTniyYcdGdvslhnMYiXyV3CCvm
 /x7QF5dPe5TxNgoDhLxgRupyndmZdzXT4bArLI6HgOHs7eE5ZbCMiZKLtmeaiHrn96zJAfvYVhK
 tTKiUHrfnLAyAYB7OoVQz6kIye7u6KRff3/REhJBf0za/vkvEp0yZWRWvc4zq2zR6CZ0ieVAJ9i
 rQuRyn2ccC0nf3Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patch 1 removes an unneeded address copy in subflow_syn_recv_sock().

Patch 2 simplifies subflow_syn_recv_sock() to postpone some actions and
to avoid a bunch of conditionals.

Patch 3 stops reporting limits that are not taken into account when the
userspace PM is used.

Patch 4 adds a new test to validate that the 'subflows' field reported
by the kernel is correct. Such info can be retrieved via Netlink (e.g.
with ss) or getsockopt(SOL_MPTCP, MPTCP_INFO).

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Changes in v2:
- Patch 3/4's commit message has been updated to use the correct SHA
- Rebased on latest net-next
- Link to v1: https://lore.kernel.org/r/20230324-upstream-net-next-20230324-misc-features-v1-0-5a29154592bd@tessares.net

---
Geliang Tang (1):
      selftests: mptcp: add mptcp_info tests

Matthieu Baerts (1):
      mptcp: do not fill info not used by the PM in used

Paolo Abeni (2):
      mptcp: avoid unneeded address copy
      mptcp: simplify subflow_syn_recv_sock()

 net/mptcp/sockopt.c                             | 20 +++++++----
 net/mptcp/subflow.c                             | 43 +++++++---------------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 47 ++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 38 deletions(-)
---
base-commit: e5b42483ccce50d5b957f474fd332afd4ef0c27b
change-id: 20230324-upstream-net-next-20230324-misc-features-178b2b618414

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

