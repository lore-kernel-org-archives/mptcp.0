Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906B149DF1;
	Sun, 12 Jul 2026 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783854167; cv=none; b=c2lMRux2fYZI++c/ofiocbPwpRD9hPGEd/3AKP3YCyyw2amkrxzd1UmQg7kZyMkRobNrqqXk7gxyoa9a3+w0sn7O9C40LIPuPyq6u6h5EHVHQiaFAlVjBfTEwaVgBYeZhBERPhQ+0ZMqF1I8ZNMe8IvUYvoZLpVPw/hrsoGTizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783854167; c=relaxed/simple;
	bh=QFAERGkwm7FFeWB0LrovUamDAkSprs7aihtdoZvXuKE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NqgIS4ekU3rs6svmcYyHYobl1gY2MT8uxc8rVDnAtFhFu1SYhIIrBsqI57OOgiUjO/W4F3pXIW385MigTN3+7HlG3YaLs506tKaBA3s2p9/ltiMNKv7GXVwstG9gCiQ25sEmjMDDTxunLKlexwqJxBeG1AL04LIL9jdrEIbWKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WxzzMJFR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjYqDSeL; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WxzzMJFR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjYqDSeL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 0B75A138025E;
	Sun, 12 Jul 2026 07:02:45 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 07:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783854165;
	 x=1783861365; bh=VmtnK3tqoDU1aIaol+aWaActTb6DTRuQA5S8IlUXC6U=; b=
	WxzzMJFRBMefM70b/YtDS4TGQzae1Lt/rly/upptZh5fiBQ/fgL1t0EVfjBFGBN8
	y3oHExa9YWDQRMyr7UQAu8Svx/w4tjxqi8/PSOMY6DvjDwL0TZKwHwZA9Ozd2pYf
	s0ypipZNS8YGe2m4DOJe+38aDBHK+jcODlukRpagOVHD9KEJkdoQqgev21V8Bgb3
	TCdD201xrmKe4YIQ1qTBGr8mMYvetvHkQoCSb6jHBr01wyoKlmdhQmLjG7/Wa4aa
	rs8eKVjx7yIIkxGCiHi9M1kuHiEPyUx1LiHzPOCzYk3arkdLbjWPxJP8Byp5TUOQ
	GxF66xEjwQreUjXukLkCxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783854165; x=
	1783861365; bh=VmtnK3tqoDU1aIaol+aWaActTb6DTRuQA5S8IlUXC6U=; b=U
	jYqDSeLxMU5ePSUGPDE9I0O+Exrzvenmm34qVl7yGd9kO5OjZM4Nba5EIOkF9dv3
	xbKJusquIu/RrdrD6CtBzIv0EDEmxbAhThdwGvQHTnpo2TDIjQEKyKCx0zVgVG4v
	MwbaQlaY/YSKqvHcswOF7zPh5R8hrBjf645qkfqkcQmWRXgi/k7HA1iEQiok67Xm
	69YEfw3juGlJftC0DsXryuUIhIaOjq2ddjeAdhPFtfFc045xVKuzffiJ8QKSF2UW
	O7Asl8sBFDCyqLasMb974+9PXhLP/sU+LeqELU777jCsaUXHy5EIQlONJRbvQD0l
	nsD4pCYVBIlHyFjN/7Jsw==
X-ME-Sender: <xms:SXRTagVsyQ8TX1iEIAxFTrUnBBvg3ouWIpLBpPooAqGRyR2NZALW9Q>
    <xme:SXRTavZP-nXVqS1pChO9GStBCMnL0eeMY-iAfuLUn6Dud2aygQe_POwJXvQ-rGkj1
    899by3cZoizkZNHBE50WoNoIx-Ocnc8el2ENhnhSOyttQHye1fMY64>
X-ME-Proxy-Cause: dmFkZTFFbWNFV8UtK7PJ0YbSmA1A6l1wZb8N5iMZiv4PmzggaXO+c+HZuMN5dbOW4/LwO4
    YrukvejgOijtkueKJtcp4wgn4EhO63TCyyzHULfYQ2kFzWvDfUC3HWcVgv98a9p3wmqOoP
    w4qayiqS0HMo3Jap3E4pumgiQ3lyrAKF9DlQo0/x7Vy2uECt+Jy4NACfXefBg4WHXnMK2A
    UENjemuL/g1YRCyXvDovMaGyHuMBa5JymL5nwjoOE3I2qwrEWoBlVH7JlrO1b+WcK48apy
    0bh/8MaX95lIq8caXuYf9xgC2zt9vvdMfjxFmpJdLGcSI6sCp93t5lGDrR6djFw1SGbSH9
    DJwEGK6oflC0+CJsijysvViaYJFn3czJOJ8wT4taro4O3sdXQE4YW1tubTULU31gMU6HDI
    npWKA0QFVWKK3PC5QuzFhriKLeIyPk0XlEhysD/nSStZ7x0lKeUDYwnJvvSAIigLSn8nWf
    PyAidznJn1v5eQA/hAL2gj9KhOqesySOSlWonQ+mNx9JRj+A/jnejg8SlNlhLkce3uj5+O
    /r9MtC7Kknkp+lg03SNpnmqr8+d7VdpV/I/EEDURuqzaOT8bFhRzha5fO5kjgbTdv/NvEG
    LeDxahJFEmmzScN38liLw+1/3K9JakxlQk2CYCzd0cMpr9LXzeOrR/yxM4wA
X-ME-Proxy: <xmx:UXRTaj0sSmZd0VqAg1Ab8vc217-LONz6IRtUmshppkUdvY60mSRlZw>
    <xmx:UXRTaork14UHHg7w8fqQyE86kpW_mANgES-srmAP6Z44K5DH5HjSwg>
    <xmx:UXRTahF3AcH9RhNQsb3uaMj_kkgPVZA8vLCVaaE8_vKD1PG-G4UdyA>
    <xmx:UXRTaq7ZeQ01Sj7O-hgfgLPJxURhNMS9O3pblaTcSMXqSYfUUfP1Rg>
    <xmx:VXRTajwxpExOzP0me6ntckPmhFUoyUd4EPzl75I2G2v1oTlEJtNxvefy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 29B00182007E; Sun, 12 Jul 2026 07:02:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: ARmmoW1aQeCk
Date: Sun, 12 Jul 2026 13:01:52 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Fernando Fernandez Mancera" <fmancera@suse.de>,
 Netdev <netdev@vger.kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "David Ahern" <dsahern@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Elad Nachman" <enachman@marvell.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "Petr Machata" <petrm@nvidia.com>,
 "Edward Cree" <ecree.xilinx@gmail.com>,
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
 "Martin K. Petersen" <martin.petersen@oracle.com>,
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
 "Wenjia Zhang" <wenjia@linux.ibm.com>,
 "Mahanta Jambigi" <mjambigi@linux.ibm.com>,
 "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>,
 "Jon Maloy" <jmaloy@redhat.com>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 "Justin Chen" <justin.chen@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>, "Yao Zi" <me@ziyao.cc>,
 "Yanteng Si" <siyanteng@cqsoftware.com.cn>,
 "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 "Julian Braha" <julianbraha@gmail.com>,
 "Joey Lu" <a0987203069@gmail.com>,
 "Shangjuan Wei" <weishangjuan@eswincomputing.com>,
 "Chen-Yu Tsai" <wens@kernel.org>, "Inochi Amaoto" <inochiama@gmail.com>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Dmitry Safonov" <0x7f454c46@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Alyssa Ross" <hi@alyssa.is>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Message-Id: <12ffac6a-649a-4e4a-8d12-0b48171e1d95@app.fastmail.com>
In-Reply-To: <20260712013941.4570-2-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-2-fmancera@suse.de>
Subject: Re: [PATCH 01/13 RFC net-next] net: ipv4: introduce CONFIG_IPV4 to decouple
 the IPv4 stack
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Jul 12, 2026, at 03:38, Fernando Fernandez Mancera wrote:
> Historically, the IPv4 protocol has been linked to the core INET
> subsystem. Because shared infrastructure like the TCP/UDP engine,
> routing or INET hashtables live inside net/ipv4/, it has been impossible
> to compile a kernel with only IPv6 support.
>
> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
> 'def_bool y' for now. This does not allow to completely disable the
> IPv4 stack yet but it lays the necessary build-system work for that
> goal.

I expect this will cause additional (trivial) build regression in the
next step when randconfig builds run into obscure corner cases, either
with INET=y IPV4=n IPV6=y or with INET=y IPV4=n IPV6=n.

I can probably give your patch (with IPV4 visible or disabled) an
early go on the randconfig tree to find these more quickly.
If I run into regressions, should I just add more 'depends on IPV4',
or do you have other plans?

Should we have some logic to ensure that at least one of IPV4 or
IPV6 is enabled? I think this would work

config IPV4
      bool "The IPv4 protocol" if IPV6
      default INET

which only allows turning IPV4 off if IPV6 has enabled.

       Arnd
