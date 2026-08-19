Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655B3515D5
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124228; cv=none; b=o8miSgz7qz2RfUNyFBodLlin8eat1120tJaNnOxY7sGyZ+/Au+Nxx144GebXHibnPclO6k3Jw/GRmQgACLThue84qgEyFxG4jzUFJybXBBLLTKXZy6q8/H66W5WYF9ppHWQVVTiV50x2tCqHtqDk0+VvE77JMV+41DJkBG7HrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124228; c=relaxed/simple;
	bh=vJOQB6OEilnNhG3zoLseoKQ2GlViVuxzRQTFP/9GVyg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LXR1zUGyKblNNXoShuWt2W8GYyqYFoBPpdXR5UH+2FfCL6VlngNmxz3ObhSu9tX8+mDhNwiRQjSTIRBOZcnYPjFSiJq98tNq5QaE2vg9GPKXvvFBb5fDvGNW55QdSFQt8FnGhuvpvx+hj9RKoqanUkNCf87sp2kDxTDn3ZdZAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Su1Oe9sh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Su1Oe9sh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AFF1F000E9;
	Wed, 19 Aug 2026 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787124226;
	bh=KzONoihoezhO22fSlL/TrPY0qTF+prGM8qZiwqmx1O0=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Su1Oe9shSq7d/6vliAQ03tF1/gSDnsFqpugijo9oY27uMoHZNEjEiUXpVwmrZ79kx
	 dZGIdUQcDh7qClKq+/21hBvwq51SeOW6+grbJrDSfESa+OkNjdyJlD7rKRAQu88/zn
	 LPp3s3ImlJWH8PVYdXE35xY/l+1Qi+PmDitOowMdbFHE2rITo9Dv+qZdLagq7WHmY/
	 FmGgEVkXEYwQthMdHbCauB0zMfoNDehCU4khsD7/4mI87kEoY33pR+hxacE1+XB51B
	 ygQT0L7PxIBqnkGsNVs0s2KbhBCEmqiEy9yLzWwJ7t6o5Xf4r17V5d+bfedMBer8ZB
	 a9++G6A20xiIA==
Message-ID: <7bf7a43655610da952266aa7bfbec76a1dcb5f22.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3 2/8] mptcp: pm: userspace: lookup: match
 port in priority
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Date: Wed, 19 Aug 2026 15:23:40 +0800
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-2-de9088549924@kernel.org>
References: 
	<20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
	 <20260807-mptcp-pm-userspace-id0-case-v3-2-de9088549924@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2026-08-07 at 10:41 +0200, Matthieu Baerts (NGI0) wrote:
> In the local address list, there can be entries with the port set to
> 0
> -- corresponding to the source port used by the initial subflow --
> and
> others with a specific port.
> 
> When performing a lookup, it is important to compare the ports to
> pick
> the right entry: when a specific port is given, then try to match it
> first. If no match is found, try to find entries with the port set to
> 0.
> 
> Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v3: new (Sashiko)
> ---
>  net/mptcp/pm_userspace.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 663cbeb79548..3f1471ec3fc7 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -33,10 +33,22 @@ mptcp_userspace_pm_lookup_addr(struct mptcp_sock
> *msk,
>  {
>  	struct mptcp_pm_addr_entry *entry;
>  
> +	/* Compare ports when set in addr */
>  	mptcp_for_each_userspace_pm_addr(msk, entry) {
> -		if (mptcp_addresses_equal(&entry->addr, addr,
> false))
> +		if (mptcp_addresses_equal(&entry->addr, addr, addr-
> >port != 0))
>  			return entry;
>  	}
> +
> +	if (addr->port == 0)
> +		return NULL;
> +
> +	/* Check only wildcard ports if no exact match with the port
> */
> +	mptcp_for_each_userspace_pm_addr(msk, entry) {
> +		if (entry->addr.port == 0 &&
> +		    mptcp_addresses_equal(&entry->addr, addr,
> false))
> +			return entry;
> +	}
> +
>  	return NULL;
>  }

Personally, I think a single-pass lookup is better than a two-pass one.
I've implemented a version and it passed the tests:

static struct mptcp_pm_addr_entry *
mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
                               const struct mptcp_addr_info *addr)
{
    struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
    struct mptcp_addr_info match;

    mptcp_for_each_userspace_pm_addr(msk, entry) {
        match = entry->addr;
        if (match.port == 0 && addr->port != 0)
            match.port = addr->port;

        if (mptcp_addresses_equal(&match, addr, addr->port != 0)) {
            if (addr->port == 0 || entry->addr.port != 0)
                return entry;

            if (!wildcard)
                wildcard = entry;
        }
    }

    return wildcard;
}

What do you think of this approach?

Also, this series has conflicts with the current export branch and
needs a rebase.

Thanks,
-Geliang

