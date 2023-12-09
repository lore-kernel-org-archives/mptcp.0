Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AF7F8
	for <mptcp@lists.linux.dev>; Sat,  9 Dec 2023 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb5xynmo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E72C433C9;
	Sat,  9 Dec 2023 01:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702084536;
	bh=6GuqF2BxUD/Rk6eUW7XcwKASsYLsp5qFBCEkNblI9HA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hb5xynmoUrOPwV5nCk6Pu5sB11hEBcvWZoy+ZQE29ETkimBJWW4pRMUPDu5sEh1Bh
	 oMb4qpP4MJSJpNJOm+p3Y/+S9TlwqW/1LF0VmVRvqjbAxrn7BR2K1I1LjgobcH0Ubb
	 lDUPHOvbIbTeZGx0J6RJn8M778/ajAkKTSUGUbv4DaWuqHGoAvL+Yd6h00MlPBEEaE
	 duY8RMKcMOqfjZl3CkVJmb00dEC2t9kCA5F1rSik3vaQz5dD8ETlfmlb2fClA5OBiT
	 azvfXFkrWBY/tPp/3YSBYsUBpy9U+woCVS0BU+5kVJzDb9kL/vWrvbSRj2fYYw/GjM
	 8Sddf0DB5f06Q==
Date: Fri, 8 Dec 2023 17:15:36 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 00/25] userspace pm enhancements
In-Reply-To: <cover.1702029538.git.geliang.tang@linux.dev>
Message-ID: <e136346b-936f-9f63-50a0-788bef0f276e@kernel.org>
References: <cover.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Fri, 8 Dec 2023, Geliang Tang wrote:

> Part 1: dump for userspace pm (patches 1-9)
> Part 2: fixes for creating id 0 subflow (patches 10-13)
> Part 3: v4-mapped addr support (patches 14-15)


Hi Geliang -

I think we should focus on parts 1-3 for enhancing the userspace PM. If 
the userspace daemon has to restart, it needs to find out which local 
address IDs have been advertised to the peer so it can avoid attempted 
reuse of those IDs, and it can send REMOVE_ADDR for those IDs if needed.


> Part 4: flush for userspace pm (patches 16-18)

It looks like the flush patches were removed after v13 except for the 
selftest (patch 18?), and it looks like patches 16-17 are not related to 
the flush operation.


> Part 5: address entry refcount for userspace pm (patches 19-25)

These patches are to address 
https://github.com/multipath-tcp/mptcp_net-next/issues/403, correct?

I think a refcount is not necessary to make the userspace local address 
list work correctly.

The userspace local address list should contain:

  * An entry for ID 0 (when the connection is started - it may be removed 
later)

  * An entry for every ID advertised with ADD_ADDR

  * An entry for every ID allocated by the kernel when an outgoing MP_JOIN 
uses an address that doesn't have an existing ID.


Entries should only be deleted by a "remove" netlink command from the 
userspace PM daemon. Closing subflows (or connection errors) should not 
remove entries from the local address list.

Does anyone remember why the current code deletes address ID entries when 
subflows are destroyed or connections fail?

If the local address list is defined as "the 
list of address IDs we have advertised to the peer", there is no need to 
manage the list as subflows are added and removed. Even when no subflows 
currently exist, the peer still can have cached address IDs from our 
device, so they must be considered valid until we send a REMOVE_ADDR.


I suggest modifying the userspace local addr code to make '0' valid. If 
there's a need to track whether the ID is unassigned, maybe struct 
mptcp_addr_info needs a separate flag for that.



Another overall note: I couldn't get the series to fully apply to recent 
export branch tags. Please remember to add a note to the cover letter 
describing what other patch series it depends on, and what order to apply 
them in! (Or give a link to a public git repo/branch)





