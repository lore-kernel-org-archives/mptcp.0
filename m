Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915A11CA6
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 07:17:49 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so62008621fa.2
        for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787867; x=1691392667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA2Np0axnCcM7zYYQ9J3PNsrfsw3IGeC9vgEKu3nCGU=;
        b=jpMYG4ou2L8vx2RUTUVRXZn7QJd4O0UHRyIOfry+GKXNJ0D69hHzOKIYQpPA6HaqRE
         umaqJcW9NZXGPZQINuL3wnrYgUKUIPz5ES5koMDs9pynqpjXiHO0T4X35LGLZqyvkUxt
         y5rrXas7E/57rsua1yTM/R2vhj/Ln+GI8yIlALAZZMw+DMJp7xcL95cs4+PT6jO7lxJI
         4in1qYNAa9Mp3ldQ5ZuTfU2Jnxvms9t8PJfqgFhC+6X45niZPOKR6/+AYAJtA4d2Uv0Q
         yYLYFl1l8p0M4CNtbKY9eLk022rVeciWFTXU+gb6zmEVa9stfbrZfEcpkrfARkIYsZwN
         eKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787867; x=1691392667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA2Np0axnCcM7zYYQ9J3PNsrfsw3IGeC9vgEKu3nCGU=;
        b=L/Ut5oYnBTykfTrroHCWWM/CH4Yz8FbGUGegBbLYBsvIGt16pcgnUCkO1K6/oiQQd+
         XIj8PRZCIs9Plit33oz2rRktoAi9nohE3MjeWPMg4DY1jJstZFmSWROp3lJuHrS6Thig
         Fi34+8lJnQjuf81SUUnbrHAKDWu9jwiUHSPRIH5ZikUiQrQ5AM7a+TBut6CSEEHalmx8
         g0StbKDwBpNWhxYQKNKSiQP/pvBGJs94V9mEkrhaVNQ6n5KfHNlT67vS0tNyBd4LI3tG
         5Z0hp95XRsw4toeoV2KTPKdWhr7igaQ6CBHcMv66xSC/3ZzbUKgYgsaF/ky5kyES757v
         9vwg==
X-Gm-Message-State: ABy/qLZUOQ/L4/n6BNkxTXpb9VcDD3uwzBgpkkx0ffQckqXPhafGiRwI
	iPrDJ8da8gIkpWk6iOO5NWQ=
X-Google-Smtp-Source: APBJJlEUHduQ6vqONIipC16XnwJoyZYKU6g5x9FU+aI2Csu22dyES0/suPxLH7mDv/letF0OMgVMig==
X-Received: by 2002:a2e:7c06:0:b0:2b9:c4f6:fdd with SMTP id x6-20020a2e7c06000000b002b9c4f60fddmr5409655ljc.14.1690787867211;
        Mon, 31 Jul 2023 00:17:47 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id f25-20020a1c6a19000000b003fe24da493dsm231228wmc.41.2023.07.31.00.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:46 -0700 (PDT)
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
Subject: [PATCH v2 09/14] ax.25: Update to register_net_sysctl_sz
Date: Mon, 31 Jul 2023 09:17:23 +0200
Message-Id: <20230731071728.3493794-10-j.granados@samsung.com>
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
pointer. We hold off the SIZE_MAX to ARRAY_SIZE change until we have
migrated all the relevant net sysctl registering functions to
register_net_sysctl_sz in subsequent commits.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/ax25/sysctl_net_ax25.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index 2154d004d3dc..db66e11e7fe8 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -159,7 +159,8 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 		table[k].data = &ax25_dev->values[k];
 
 	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);
-	ax25_dev->sysheader = register_net_sysctl(&init_net, path, table);
+	ax25_dev->sysheader = register_net_sysctl_sz(&init_net, path, table,
+						     ARRAY_SIZE(ax25_param_table));
 	if (!ax25_dev->sysheader) {
 		kfree(table);
 		return -ENOMEM;
-- 
2.30.2

