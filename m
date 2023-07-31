Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3914F92
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 07:17:55 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso8572725e9.1
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787874; x=1691392674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLmPwUxElpGPIItGBie9qSPLiGC8xTssPnC4wjmH8Co=;
        b=IpykfJb7hcUQStL2f0jwevdksgcPlej76+9Dvlr1etAys3iM7VBIf1dA9mPPbAYwEb
         ovJ3JqI/719OJKxsZ6C+Z8AKuT8aGJ8b4PaOI4zBQOwthNmU3T7saorlPq0OFGxCpSve
         zgNuz5M+is0YyrITjMyHTZmRVk7n/qm4sjOgmkOO54OTjqAif6/SwiRsLOZuEL+B98qp
         GAICvEE8SmvklGodmsUNzWyuYtuSW1QtXfHA5t9EADp21BbKXmmGvog+lzyPMjWS0+o9
         YAQafxqNi3TE5xfJHhmTEkye+I77LFFqaIu/Xim5e2O7+IpfnM5rQvYU0EPtAIag7AvX
         7qPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787874; x=1691392674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLmPwUxElpGPIItGBie9qSPLiGC8xTssPnC4wjmH8Co=;
        b=SuSBbbNRqtVHAvYGKbL0IXd7Ig4aK2nOzZCHJaRbCVF/CUCVMbrMkmwT7rr+D7yEtz
         mvRFrnvoyLnqw+dQG7W35ExKBsQgtatqKAN0Dv2L55lctpgK93pZfVQG7TTOZn1bVvI8
         +l62VslroGQkSj86MMeARN+5WAoAazRB1ausKnjvG+V2YtD7D+1lu3t9UQv861yz+EA3
         U3nYenQSDQMkRzuCxLW2uqYX5qIour2XHm2UJG8LQXVVLGIXXw6lAsb3s7+6NMa98tMM
         o3bzMafMuOWuez4NpjtkBOEwot6CAuyL6IeRt4rHbpTR+MPKB6pvMu1Cevcbd3thw6PQ
         2CWA==
X-Gm-Message-State: ABy/qLbagQCBUxKGtOH3vKPlgmzbh57qUdyS/XFDYD9gGeTHXoFNs3qE
	66rBcsBAADKSPhZb6vcCgKA=
X-Google-Smtp-Source: APBJJlEWJpIRsYgvvSuwbjUjC75DanD11Vxqj9Uy7oRYPl2tqIHO5CFVTD3oPksJ5zp8xbINTXCHDg==
X-Received: by 2002:a5d:474c:0:b0:317:52d2:d196 with SMTP id o12-20020a5d474c000000b0031752d2d196mr6971143wrs.33.1690787873675;
        Mon, 31 Jul 2023 00:17:53 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b0031434c08bb7sm12018523wrm.105.2023.07.31.00.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:53 -0700 (PDT)
From: Joel Granados <joel.granados@gmail.com>
X-Google-Original-From: Joel Granados <j.granados@samsung.com>
To: mcgrof@kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Iurii Zaikin <yzaikin@google.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Kees Cook <keescook@chromium.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	mptcp@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	coreteam@netfilter.org,
	Jan Karcher <jaka@linux.ibm.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Will Deacon <will@kernel.org>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	bridge@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org,
	Joerg Reuter <jreuter@yaina.de>,
	Julian Anastasov <ja@ssi.bg>,
	David Ahern <dsahern@kernel.org>,
	netfilter-devel@vger.kernel.org,
	Wen Gu <guwen@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	linux-wpan@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	Karsten Graul <kgraul@linux.ibm.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-sctp@vger.kernel.org,
	Tony Lu <tonylu@linux.alibaba.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Florian Westphal <fw@strlen.de>,
	willy@infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-rdma@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Simon Horman <horms@verge.net.au>,
	Mat Martineau <martineau@kernel.org>,
	josh@joshtriplett.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-hams@vger.kernel.org,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	netdev@vger.kernel.org,
	rds-devel@oss.oracle.com,
	Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 12/14] vrf: Update to register_net_sysctl_sz
Date: Mon, 31 Jul 2023 09:17:26 +0200
Message-Id: <20230731071728.3493794-13-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move from register_net_sysctl to register_net_sysctl_sz and pass the
ARRAY_SIZE of the ctl_table array that was used to create the table
variable. We need to move to the new function in preparation for when we
change SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro.
Failing to do so would erroneously allow ARRAY_SIZE() to be called on a
pointer. The actual change from SIZE_MAX to ARRAY_SIZE will take place
in subsequent commits.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/net/vrf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bdb3a76a352e..f4c3df15a0e5 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1979,7 +1979,8 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 	/* init the extra1 parameter with the reference to current netns */
 	table[0].extra1 = net;
 
-	nn_vrf->ctl_hdr = register_net_sysctl(net, "net/vrf", table);
+	nn_vrf->ctl_hdr = register_net_sysctl_sz(net, "net/vrf", table,
+						 ARRAY_SIZE(vrf_table));
 	if (!nn_vrf->ctl_hdr) {
 		kfree(table);
 		return -ENOMEM;
-- 
2.30.2

