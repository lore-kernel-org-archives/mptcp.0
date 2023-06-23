Received: from sipsolutions.net (s3.sipsolutions.net [144.76.43.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CF3D6A
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 10:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Lk442Og9qeSuSAMtnFnHXSps46eB9vX+oT9sJwzVZUI=;
	t=1687516631; x=1688726231; b=fJBo1CVGwa+1AuzVFSFpkwuGKQB/5Aix8MJEH/CqWKyuZrP
	hGe88KyQek+BPO3d/OA75BhXjpsqb8b3uRwQgxGwJLjLDZoMuy6ll0nPdpP3S91Rwr0aGmpysKnzs
	f2ILtqlsrrolQUR/zJZYetLU3dDAs3qBUK0WoNohZtjJh68eJwzSC7N95bpR8AV768jrPoA5dQ5T/
	ZbVLqhBcKXf5KlqdPXIi90d27/0tiNWRBZJzTVTmavXJl7h8AZSFF9eBzM6n3k+ZY/Uvh+0CpuXeS
	hKzGhO6PPiEnGsSDRCNKj6bzJBAgFeUADteoedgJxhfnAiaV39uqgmlI5kUav/ww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qCe9m-00FgPV-1a;
	Fri, 23 Jun 2023 12:36:46 +0200
Message-ID: <19d17ee302892f48f9b6110ec6c2ccccf0c1b9ef.camel@sipsolutions.net>
Subject: Re: [PATCH 0/8] Fix comment typos about "transmit"
From: Johannes Berg <johannes@sipsolutions.net>
To: Yueh-Shun Li <shamrocklee@posteo.net>, Jakub Kicinski <kuba@kernel.org>
Cc: jgg@ziepe.ca, leon@kernel.org, anthony.l.nguyen@intel.com, 
 davem@davemloft.net, kvalo@kernel.org, jejb@linux.ibm.com,
 pabeni@redhat.com,  apw@canonical.com, joe@perches.com,
 linux-rdma@vger.kernel.org,  netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,  linux-scsi@vger.kernel.org,
 mptcp@lists.linux.dev,  linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Jun 2023 12:36:44 +0200
In-Reply-To: <50a88781b9e2a80588438c315167bbec@posteo.net>
References: <20230622012627.15050-1-shamrocklee@posteo.net>
	 <168748862634.32034.1394302200661050543.git-patchwork-notify@kernel.org>
	 <50a88781b9e2a80588438c315167bbec@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2023-06-23 at 08:51 +0000, Yueh-Shun Li wrote:
>=20
> >   - [3/8] zd1211rw: fix comment typo
> >     (no matching commit)
>=20
> Should I rebase the local branch onto netdev/net-next/main
> and send the "no matching commit" patches again?
>=20

The wireless one is on our radar, no need to resend.

But: https://lore.kernel.org/r/87y1kncuh4.fsf@kernel.org

johannes
