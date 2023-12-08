Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79D366
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 00:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC+T1vr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7A3C433C8;
	Fri,  8 Dec 2023 00:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701996416;
	bh=o9ZJOzZW1TuEH+W72+L/5HQA/J0sf5853ITYNAeiKLY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NC+T1vr9sOM0BEGjB1hyJL1/M4r/nUNM7VZ2qosCJ3EBz+Z8HzDfWKX8Rewq7VrKD
	 2q89VNEmoS2bFJ1lHtnZKNA29eLOAsfGKyL4sINYjrwqxuJlkJDXXz/i/OguBYzQLY
	 ooUS4EDDnqnyo0oUTK6cH3OIjgpZFm4klim6566yieRTPqKYfwavUoBE0a/tkqV7l8
	 s/Nie9okuvxWqZKZTFIhUtRGgEqLJ1yXe2ZBWiuIgL0q19rZ5AQhIxmofyE4xxTLvM
	 R0POFqX5XWrmFJ2PdmY9Nnp90gsJq9H1dVvfQeTmhr66QKHdaneaOra+NcF8JFPoN8
	 JrWioO+gbo9lg==
Date: Thu, 7 Dec 2023 16:46:55 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v13 22/32] mptcp: flush userspace pm addrs
 list
In-Reply-To: <8206a3d8e4a1e2b93362e2a7c7e23adc15194544.1701180969.git.geliang.tang@suse.com>
Message-ID: <0fb0927f-fd55-84f6-6a72-64131ad53928@kernel.org>
References: <cover.1701180969.git.geliang.tang@suse.com> <8206a3d8e4a1e2b93362e2a7c7e23adc15194544.1701180969.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 28 Nov 2023, Geliang Tang wrote:

> This patch adds a new function mptcp_userspace_pm_flush_addrs_list()
> to free the userspace local addresses list. Invoke it when flushing
> addresses from netlink commands.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/pm_netlink.c   |  2 ++
> net/mptcp/pm_userspace.c | 23 +++++++++++++++++++++++
> net/mptcp/protocol.h     |  1 +
> 3 files changed, 26 insertions(+)

Hi Geliang -

Do you have a use case in mind for the userspace flush operation? I think 
this functionality should be implemented by the userspace PM, which can 
list the subflows and then disconnect them as needed.

Thanks,

Mat
