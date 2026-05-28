Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D32E738C;
	Thu, 28 May 2026 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981827; cv=none; b=Rs09ofggeNdJm04F6NMdbGga4V9rszFJs4Eu/yA6+t1eaiUyEXxEvVUX8cTu0noK9vsW2nI0fFAZx68sUXCWy0v3dSoXZn3vwvCGWoym6zLQS03UO/oOWE5B4N3xt4hOfWImcHroG3qXP7nCExjeIHm9lFkHG6hlPev7p5UQ7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981827; c=relaxed/simple;
	bh=XNVV5RSrjS7o4TZe/Jrrlts9X2T/sN3FLRhdTJhxOMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdPbKeasuzNRDDSjblUO+sax7Dt4/znSGrs79mnDuSsOAMRhIUuod4W7+gH1IFvQpaqxTU1IPtPVHCZ00evqLLCcsvHDL3LQgb8/CCvWEbwlHNwhZD6v77SAx1LbF8fOjJrCP5fcdkLAXx/84y/GFFgn29uf651DogsalxpIb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6PQ6Vwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6PQ6Vwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C0A1F000E9;
	Thu, 28 May 2026 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981826;
	bh=XNVV5RSrjS7o4TZe/Jrrlts9X2T/sN3FLRhdTJhxOMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D6PQ6VwtW6cAq0yzywDit9p+dufchYyF+Ef8J4paq0mpWLghLZu/sdBNX6riFA9b3
	 Y1F1hP5qh7w0UTdPEYH3sr/3hy42GlbcIYehzVP0wZEUWDTW7CeTzMd7tNBGqkoRxN
	 ycYk/SHD3/JsTz9lapKL9K46+dbOUxujaYQQgzYIRcxcXSQyiVUNng37MOCkgh3BqU
	 daOO6Zh88lKbt3XxtNyB1+1SQsY+HAIw1BBQN3YikJtv1Ix2CLQ10+wZWtESggLSmH
	 8Eq39SMfiFfWJjKBJIWV4mEY74kxof0pQN6UfcFPQoDI6pphcJZ/7G3cKyeFRd42Du
	 3BPWOHxHposNA==
Date: Thu, 28 May 2026 08:23:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Hannes Reinecke <hare@suse.de>, John
 Meneghini <jmeneghi@redhat.com>, Randy Jennings <randyj@purestorage.com>,
 Nilay Shroff <nilay@linux.ibm.com>, zhenwei pi <zhenwei.pi@linux.dev>, Hui
 Zhu <zhuhui@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH 02/11] nvmet-tcp: implement accept mptcp proto
Message-ID: <20260528082344.7e4cd1a1@kernel.org>
In-Reply-To: <a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
	<a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 11:10:36 +0800 Geliang Tang wrote:
> Dedicated MPTCP helpers are introduced for setting accept socket options.
> These helpers (no_linger, set_priority, set_tos) set the values on all
> existing subflows using mptcp_for_each_subflow(). The values are then
> synchronized to other newly created subflows in sync_socket_options().

These are not protocol specific options, why do we have to export
MPTCP-specific functions for them?
