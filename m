Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [95.163.41.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B424219F1
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="AO0v24dZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=O3/MxlqfgzD7aH9R4Xu2aIEUAWpneSV7RKHc9XpaRHk=; t=1702296225; x=1702386225; 
	b=AO0v24dZYBQ7oGP4tawPbDTNkbjqmfmzW+jQn4dexE7Qvc6eEF8WLhe3vUZJ8ibFDxawBileIRQ
	iHj2BlJcRLkFEFxEyRFShhCrxp6ikeOCi6Q4wvZKX1zQFTBI9uE9ib/h0pTbRrJO+utC1GhJYwJgN
	j7MGVlgGyIn5mlPP4XEiuoec02qbOSlH5fwt82D/4vJu6zl6DB2DydjahaZ7Hs5L9gI8gFd/Ts9Pq
	0TDgD1e5wS+aDgeLak1XJte86OmQXakLnOx/pHvvOX+lBlnsnZjuCMi7QgUkVSpH5neAyjetz5IRd
	naLU7Eitg9u7K0igukq/NsHfSseyGKhJQcOQ==;
Received: by smtp44.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1rCf0Z-009382-1L; Mon, 11 Dec 2023 15:03:36 +0300
From: Maxim Galaganov <max@internet.ru>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	Maxim Galaganov <max@internet.ru>
Subject: [PATCH v3 mptcp-next 0/3] more sockopts for ephemeral ports
Date: Mon, 11 Dec 2023 15:03:06 +0300
Message-ID: <20231211120309.20752-1-max@internet.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp44.i.mail.ru; auth=pass smtp.auth=max@internet.ru smtp.mailfrom=max@internet.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD97533543916A0F71AD286D97BFFE3DA5DB7E67E5414E74A44CD62213F67905E7A7AADACD4952D7D824A1AA256EF13DC9F31A0EA4EC84C67EC406EA159844E9C80
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C2204D4F9A221771EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063745476ED688D943148638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D84B9BE95C8BDB972BEC623F68052AD5716F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE70F3DDF2BBF19B93A9FA2833FD35BB23D9E625A9149C048EECCD848CCB6FE560CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006373E1F328EEA58DAAF389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637A4D9F61C333A77D0D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE708D9EBE08A83D6D1EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5278DA827A17800CE7A03E8F3C2D3812562EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE78E7FE8CC7D0C7735731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A580103A7BA9CB3DEF0A0CAB60E820A5D9A5BB2383CD4DD81EF87CCE6106E1FC07E67D4AC08A07B9B01E44367C8E80A7B49C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFBE46B6217E419A9E506F5A5910AEC2F47E5236AE8138587EE487ED22954F098A0FDE042572883009FC43826C574F1C6F79E1DB5CF76021975B20235EF6986158E48CAC7CA610320002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojUXpChnEw0AXkkR6JGWdXJw==
X-Mailru-Sender: 4A46F6E6BB1A04662A3B81E17F92FA49571B08C994E78F35C46AA1A4A29F4F98130BB289A1C4FBB910AB1EC7B4FC32D5C77752E0C033A69E0ACD20E4C8A7C03EF0AEF442C4C8402EB4A721A3011E896F
X-Mras: Ok

Support useful sockopts that allow fine control over ephemeral port
usage.

v3:
 - Change patch 2/3 with regards to commit d9f28735af87 ("Use
   READ/WRITE_ONCE() for IP local_port_range.")
 - Drop Mat's Reviewed-By tag in patch 2/3 because of changes
v2:
 - Add patch 1/3 with function name change (Mat)
 - Fixup checkpatch errors in patch 2/3 (Mat)

Maxim Galaganov (3):
  mptcp: rename mptcp_setsockopt_sol_ip_set_transparent()
  mptcp: sockopt: support IP_LOCAL_PORT_RANGE and
    IP_BIND_ADDRESS_NO_PORT
  selftests/net: add MPTCP coverage for IP_LOCAL_PORT_RANGE

 net/mptcp/sockopt.c                           | 27 ++++++++++++++++---
 .../selftests/net/ip_local_port_range.c       | 12 +++++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.43.0

