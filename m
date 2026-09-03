Received: from mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1932B108
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 02:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400975; cv=none; b=BFZ5cY6ttn3ai3qxdi/3pNuzjTHBqla1qYTNYRCsB2EfxiFr1RNcPN9jJ3UEVLeMeDm4x05u5Rsz0hGDKmMHy5NnWknAUDNJNDdcrkpzJjFEvKiiF9eVabBeG77mJogxTpp6JdOnGfMCNSixaoh3ZG6/NVh69w4TtRe7jgyhI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400975; c=relaxed/simple;
	bh=USBP9grbUHcS0UCGWyGH26khHr7rl5lViseDpt88lSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkSL0QIZk3d+/BTK1kK/O2BukPQ7qGsZKW1ff6AFpL0rVHwYOJGzyudEYa7Ri+owp5B4j8k3AOI2RdAQFU11WA/J6ssm19D8K6BAQ4CfZBWGPVXg5S1wXS+UHqDW74IELeyK03Rvhloas0mUoa//kDkSIrmf8x5y5SZHZDZXSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sm/TU8QT; arc=none smtp.client-ip=91.218.175.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sm/TU8QT"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=USBP9grbUHcS0UCGWyGH26khHr7rl5lViseDpt88lSA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788400971; v=1; x=1789005771;
 b=sm/TU8QTI1xBILHGxkwDudknLjV+pSux68jAGITE+pcRkjOiicLwq7dqvhX9Yte5gWl4s0/4
 Z6M6X4fPkfLR1LJBfgyKHNaC4aRrFXTuOKqzBSodga2K116fAE54PwmL5ZsE9zQNlKmUeHkfX9H
 f/cXpTp8THExXzRvSebhz1QE=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c34314edb07b9cd3;
	Thu, 03 Sep 2026 02:02:51 +0000
X-Mizu-Trace-ID: c34314edb07b9cd3
X-Migadu-Flow: FLOW_OUT
Date: Thu, 3 Sep 2026 10:02:46 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Hangbin Liu <liuhangbin@kylinos.cn>,
	MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Message-ID: <apjU-uM8dvxnVcaP@fedora>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org>

Hi Matthieu,

Sorry, My mbsync has some delays and I post v2 too quick before catching
your feedback. I will update the patch with your feed back and re-post
tomorrow.

On Wed, Sep 02, 2026 at 12:00:40PM +0200, Matthieu Baerts wrote:
> > The iptables/ip6tables check inside mptcp_lib.sh is kept in case any
> > one still need them.
> 
> Please remove them, not to be tempted to use them.

OK, I will.

> 
> > Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/mptcp/config        |   3 +
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 136 +++++++++---------------
> >  2 files changed, 51 insertions(+), 88 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> > index 59051ee2a986..0d0a744c4ca8 100644
> > --- a/tools/testing/selftests/net/mptcp/config
> > +++ b/tools/testing/selftests/net/mptcp/config
> > @@ -30,6 +30,9 @@ CONFIG_NET_SCH_NETEM=m
> >  CONFIG_NF_TABLES=m
> >  CONFIG_NF_TABLES_INET=y
> >  CONFIG_NFT_COMPAT=m
> > +CONFIG_NFT_NUMGEN=y
> > +CONFIG_NFT_REJECT=m
> > +CONFIG_NFT_REJECT_IPV4=m
> 
> Even if we currently don't need the v6 version, I wonder if we shouldn't
> add it here. Up to you, when we will need it, we can also add it here, fine.
> 
> I wonder if we shouldn't remove the ones linked to IPTables. I was
> thinking that maybe we could keep them for debug purposes, but same as
> the reject v6, we can add them when required instead of guessing which
> ones would be useful, "just in case". So yes, do you mind removing the
> ones that are no longer needed, please?

OK, I will

> > -# IPv4: TCP hdr of 48B, a first suboption of 12B (DACK8), the RM_ADDR suboption
> > -# generated using "nfbpf_compile '(ip[32] & 0xf0) == 0xc0 && ip[53] == 0x0c &&
> > -#				  (ip[66] & 0xf0) == 0x40'"
> > -CBPF_MPTCP_SUBOPTION_RM_ADDR="13,
> > -			      48 0 0 0,
> > -			      84 0 0 240,
> > -			      21 0 9 64,
> > -			      48 0 0 32,
> > -			      84 0 0 240,
> > -			      21 0 6 192,
> > -			      48 0 0 53,
> > -			      21 0 4 12,
> > -			      48 0 0 66,
> > -			      84 0 0 240,
> > -			      21 0 1 64,
> > -			      6 0 0 65535,
> > -			      6 0 0 0"
> 
> Good to get rid of that. Also not to have get_maintainer.pl cc'ing the
> BPF ML just for that :)

Got it.

> 
> >  init_partial()
> >  {
> >  	capout=$(mktemp)
> > @@ -147,6 +110,14 @@ init_partial()
> >  		if $checksum; then
> >  			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
> >  		fi
> > +
> > +		ip netns exec "$netns" nft add table inet mjoin_table
> > +		ip netns exec "$netns" nft add chain inet mjoin_table input \
> > +			'{ type filter hook input priority filter; policy accept; }'
> > +		ip netns exec "$netns" nft add chain inet mjoin_table output \
> > +			'{ type filter hook output priority filter; policy accept; }'
> > +		ip netns exec "$netns" nft add chain inet mjoin_table mangle \
> > +			'{ type filter hook output priority mangle; policy accept; }'
> 
> I hope having this done by default for all subtests will not have a big
> impact at the end when using a debug kernel. Do you mind checking the
> impact, please? Just not to add a few seconds for each of the 130+
> subtest if it is only needed in some of them.

It shouldn't, I will test the running time before/after the change.

> 
> If it is, we could move that to a new helper and call it when 'nft' is
> required, it shouldn't be in many places I guess. This new helper could
> also be used to add new rules, or this could be a "reset_" helper, I
> didn't check what would be best.

I will check if this could be add as a helper.

> > +	nft_handle=$(ip netns exec "$ns2" nft -e --handle add rule \
> > +		inet mjoin_table output meta nfproto ipv${ip} \
> > +		tcp option mptcp subtype add-addr \
> 
> That's clearer, nice!
> 
> I just hope devs and CIs will use a recent enough version for nft (>=
> 1.1.2 from Apr. 25) to support mptcp subtypes. (Fine to use them, no
> need to have a fallback mechanism.)
> 
> > +		drop | head -n1 | awk '{print $NF}')
> 
> Why do you need "head -n1 | awk '{print $NF}'"? Can we not look at the
> ret code like we did with IPTables?
> 
> Same below with the RM_ADDR subtype, but for the reject ones, you do
> check the ret code.
> 
> EDIT: mmh, I see you are using "nft_handle" below, but not the one set
> here, right?. That's not very clear when it is set in the function and
> used later. Plus this field is not reset before/after each subtest. Is
> this really needed? I guess you used it for others because it is easier
> remove rules, right?
> 
> If you don't need this one (or any set in helpers), don't set it/them,
> and don't use a global variable. Or reset it in init_partial, but prefer
> using local variable with a limited scope.

Yes, we don't need the handle in other place, which I will remove them.
But for endpoint_tests(), after adding rules in reset_with_tcp_filter,
we need to remove the rule outside. I will reset it after each test.

> 
> Also, maybe clearer to use 'nft -j' with 'jq' to get that (if possible)?

I check the output of `nft -j` (paste an example at the end of mail),
which looks not each to get the rule handle easily.


> 
> One last note: for new features linked to MPTCP that might take multiple
> versions to get ready, it might be better to send these patches only to
> the MPTCP ML (no need to add anybody else in cc). Then we will apply
> them in our tree and send them to netdev when we consider them as
> "ready" (and hope for Clashiko not to get back to them days/weeks later,
> but that should be a temporally issue :) ).

Thanks for the notes. I used to rely on `b4 auto-to-cc` too much...

Regards
Hangbin

An example of `nft -j` output:
{
  "nftables": [
    {
      "metainfo": {
        "version": "1.1.6",
        "release_name": "Commodore Bullmoose #7",
        "json_schema_version": 1
      }
    },
    {
      "table": {
        "family": "ip",
        "name": "filter",
        "handle": 1
      }
    },
    {
      "chain": {
        "family": "ip",
        "table": "filter",
        "name": "OUTPUT",
        "handle": 1,
        "type": "filter",
        "hook": "output",
        "prio": 0,
        "policy": "accept"
      }
    },
    {
      "rule": {
        "family": "ip",
        "table": "filter",
        "chain": "OUTPUT",
        "handle": 2,
        "expr": [
          {
            "match": {
              "op": "==",
              "left": {
                "&": [
                  {
                    "payload": {
                      "protocol": "tcp",
                      "field": "flags"
                    }
                  },
                  {
                    "|": [
                      "fin",
                      "syn",
                      "rst",
                      "ack"
                    ]
                  }
                ]
              },
              "right": "syn"
            }
          },
          {
            "match": {
              "op": "==",
              "left": {
                "meta": {
                  "key": "mark"
                }
              },
              "right": 1
            }
          },
          {
            "counter": {
              "packets": 0,
              "bytes": 0
            }
          },
          {
            "accept": null
          }
        ]
      }
    },
    {
      "rule": {
        "family": "ip",
        "table": "filter",
        "chain": "OUTPUT",
        "handle": 3,
        "expr": [
          {
            "match": {
              "op": "==",
              "left": {
                "&": [
                  {
                    "payload": {
                      "protocol": "tcp",
                      "field": "flags"
                    }
                  },
                  "rst"
                ]
              },
              "right": "rst"
            }
          },
          {
            "match": {
              "op": "==",
              "left": {
                "meta": {
                  "key": "mark"
                }
              },
              "right": 0
            }
          },
          {
            "counter": {
              "packets": 0,
              "bytes": 0
            }
          },
          {
            "accept": null
          }
        ]
      }
    }
  ]
}
