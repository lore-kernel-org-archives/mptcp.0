Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1034A5EB3;
	Thu, 10 Sep 2026 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054658; cv=none; b=ItUJy4JcJN+JijDZktLUxn9wrH4K61B+2YqJ076vxNcwhTu6t75107+WnlPAuutnDv0B3YxgvDJIqYkyndZDrVWNogAAVXY8nSEWFOMiXSa1ENtiKF93ae7M80oyyc8JwWfL9/iIozoSdbuox4HLon4SlNRbQMvgRhLIy6UyqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054658; c=relaxed/simple;
	bh=tzfrxLbW18XBupQQO4Z4sOHkODX/2tTbZQV7+HM+Wto=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V2xlVrrdhlHQt3KCuLDQGGzHXL4ICi4okwbLVXZuQZgJoyxclUY6Sxvcy5YszKdtBDFw3Ql7vOo3Bl8a1NRUoKJqoOsp114rBGn2EFLP1NxTcR1Lh+kQykoPvsmT2OlXgf6i6BlKJYgbCr5ICa+GtGH26Zd/ERzm2KEwqO74aBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=g5YX+XDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mjj1H69q; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="g5YX+XDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mjj1H69q"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id B78891300388;
	Thu, 10 Sep 2026 11:37:29 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 10 Sep 2026 11:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789054649;
	 x=1789061849; bh=VJHi3AALrojUsaiH2K9JRyFh6yN6vM9XW4bo5EfCLvk=; b=
	g5YX+XDAJclx6iQY1Iqpvad/dhrXmtpPU4X7PHlSgR64ReSdtRKtKAHoCH7XVsr5
	hAoaD2CjknoqFaItBRP2Pce1s5t+MBHlX5z6PSL9MFShemil7OeGznVKek97Pboj
	pOYd7bm9YwDodqlP0W6v+izYml6crN4RUubmoSZ24C7XJk6JFapLKhvb8RNOa9fU
	s9DAERYBnqQIx6FjZ9VJdtmLrsrdcXcqAsaEWv+3/dnl5QWZYUgt9eOEPAnHh//o
	GqHfb2N9eRIZ7x6p7Yf4XLM9osYhuuGRF0GCvYc4NhczWcBbp7F3ujKQMS5sGZFE
	njVBCvnGUlw1aVe55lI0Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789054649; x=
	1789061849; bh=VJHi3AALrojUsaiH2K9JRyFh6yN6vM9XW4bo5EfCLvk=; b=M
	jj1H69qJ9QbYpI2qqgrm0TY1an5n7bAIzQ0T4sIOc382Q5JiSEzvGzcnytPog3mX
	YTl40hPZ5Doi8vrUsnS8gyQP3QmUPDhjisRddU4Mg8XKLI/Ux3ZCO+ZiVFyUrTYQ
	mkyfvndbskAGq/u+yA4ML2PgHbke7KkCVP5yPRG/VCZ9u9If5V66tyjKEaHiZW4W
	DJASGFMLx2pJegmYltp2DTEo5BfCHoo162GdBUoBaBzw4KPSpMHCw/cw77gIvrxO
	frBXjWuRTd2Dm1BkDcyvLUHrL3S3F5aBB07UJ6QjSl1CFAF2eNcVeesYQo4gNvEc
	2rp6udhsJugr91rgSQmsw==
X-ME-Sender: <xms:qs6ialjxbEuodcS0_ZTw49mWDlh3-eH5ipz4y--9tvyE15ehv0kuGA>
    <xme:qs6iak2m5qY1JZA52TgCLnb0Zlxl2I7QizMK2xUaH33EcsB7aIS8Gn1OjVrM5licJ
    6tWlaF6EbXIiUUb37baJ0Zd0PN4oJ0KtYtQwTmputgqJWm-6V4jymhG>
X-ME-Proxy-Cause: dmFkZTFEwk/pbFsgZVvj1/HzO07XC8c86PahbIj9Ip0Bc489VSmLqZw2fxt9jqTF6ASy2J
    Bh8LpJFRvRMfxgrm0BzqpnQ4+FLZVi6/PYWufUjxT9Vw2yLZMvXhGutXjCdn5zpysql4rf
    4oXu8f8leUGkFACC3NRJZNhD3z1gLg3BuiiSNulTSbNf/7sZabwsiK4Ivzij5BKUo/pvlm
    N5bsM1GtBKSA2QAmu2L9srOMeJlcR+G3QpuNNzrAlfxtUkOtu1ETj8xY0ae0n16CaydZ7o
    0SYTEts/JKJ/hF8H5riazj4NnaBJJINfKYCXtU2ogsd4knZf2c6XXMR7LDauOa3DULeriZ
    0zecyUgKRcqt+NBZFIG8DW19AN2ywWhsRUrQ3XXV5vcRLgJ4+0Xr/XpS4f8hEyG0LtKFqt
    QnpEuZK818HonIlCCpCzRvx5ykclnNC0zhvRgqyrLMdw1J/ipnqJ/ufaaxN1IjTJXgKNYS
    OTydTB/ZaZX67n+6HNlgcl4plIjbODbPBp0bqLPXFArdRv6l/GqG7nWmZuQ2/dwI+RA6rG
    QyZZ8rIoMag4LJSVL6jK/uYEStG2jXNGSqxUE2hRLSUV++qO702qwXCJbFQ7sdrkjKip51
    kT2tH8QDoaWCFZEfJgoWEwICI/2gQcKdPgM7OZxkPWi4zRiW1TF1JGHhqSDw
X-ME-Proxy: <xmx:sc6ialjamB9SeQnHab_t6ZRsQqT-buxwQbX7Pk1AlPeCCTQb7rOOeQ>
    <xmx:sc6iaglIqAf0vosGUApMblzQyeJj-NLS64wxskaXgk2cV7M71tEuZw>
    <xmx:sc6iaiTuMxs-CFVvJ2UHUpblwBGAL8YpG-Y6W7CwFQlvVLQUZWL9Mg>
    <xmx:sc6iasWedQvENNAVhlBvV-KNGWkAMnU-r3agZilH1yq9Zos-xHWiZQ>
    <xmx:uc6ian8Q2FSkLT9gPSPBqk5JaLSiRD4MeryCzmrJXmDUbfNMGy4g4w1i>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A91DC32A007B; Thu, 10 Sep 2026 11:37:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Ay04W235egbV
Date: Thu, 10 Sep 2026 17:36:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: Netdev <netdev@vger.kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Eric Dumazet" <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Elad Nachman" <enachman@marvell.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "Ido Schimmel" <idosch@nvidia.com>,
 "Petr Machata" <petrm@nvidia.com>,
 "Edward Cree" <ecree.xilinx@gmail.com>,
 "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Saurav Kashyap" <skashyap@marvell.com>,
 "Javed Hasan" <jhasan@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>,
 "Varun Prakash" <varun@chelsio.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Marek Lindner" <marek.lindner@mailbox.org>,
 "Simon Wunderlich" <sw@simonwunderlich.de>,
 "Antonio Quartulli" <antonio@mandelbit.com>,
 "Sven Eckelmann" <sven@narfation.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Matthieu Baerts" <matttbe@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>,
 "Geliang Tang" <geliang@kernel.org>, "Julian Anastasov" <ja@ssi.bg>,
 "Aaron Conole" <aconole@redhat.com>,
 "Eelco Chaudron" <echaudro@redhat.com>,
 "Ilya Maximets" <i.maximets@ovn.org>,
 "Allison Henderson" <achender@kernel.org>,
 "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>,
 "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>,
 "Mahanta Jambigi" <mjambigi@linux.ibm.com>,
 "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>,
 "Jon Maloy" <jmaloy@redhat.com>,
 "Tung Quang Nguyen" <tung.quang.nguyen@est.tech>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Casey Schaufler" <casey@schaufler-ca.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Julian Braha" <julianbraha@gmail.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Neal Cardwell" <ncardwell@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Alyssa Ross" <hi@alyssa.is>,
 "Joel Granados" <joel.granados@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>,
 linux-security-module@vger.kernel.org
Message-Id: <cda5d4e9-49a5-4d6f-93d4-fb50d74ed5ce@app.fastmail.com>
In-Reply-To: <aeb37452e976f5d44540ac3a0999d07b@tipi-net.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
 <aeb37452e976f5d44540ac3a0999d07b@tipi-net.de>
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to decouple the
 IPv4 stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 10, 2026, at 17:11, Nicolai Buchwitz wrote:
>> diff --git a/net/packet/Kconfig b/net/packet/Kconfig
>> index 2997382d597c..00fda9e08cb0 100644
>> --- a/net/packet/Kconfig
>> +++ b/net/packet/Kconfig
>> @@ -5,6 +5,7 @@
>> 
>>  config PACKET
>>  	tristate "Packet socket"
>> +	depends on IPV4
>
>    depends on IPV4 || !INET
>
> Otherwise this would break existing configs with INET=n. The same 
> applies to other affected options that currently permit INET=n.

Since that's a lot of symbols that all need the same dependency,
maybe we could have an intermediate symbol for it:

config IPV4_IF_INET # or any better name you can think of
      def_bool IPV4 || !INET

Similarly, everything that currently has 'depends on INET && IPV4'
could be simplified to just 'depends on IPV4', and the leftover
'depends on INET && IPV6' from the days of modular IPV6 can now
become 'depends on IPV4'. We only needed to list both in the past
to deal with the IPV6=m case.

       Arnd
