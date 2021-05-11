Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68D72
	for <mptcp@lists.linux.dev>; Tue, 11 May 2021 23:17:24 +0000 (UTC)
IronPort-SDR: 0wD2SGbnlvAqy/09ADQnUXgcyQSqaW6kMa/D1zhCNdyw+aNfSNwapHRrRltG/JaWF116X3nWti
 jC4xOVtTt7QA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="260831770"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="260831770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 16:17:24 -0700
IronPort-SDR: /Ea0EWK1IS+dwl31oThqRlzBlewRYfzBD4/i0DYPw3UwjzJGNTmW1eblIocxskckpYGfRFiHoo
 PkUTqtneGXhQ==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="537219337"
Received: from kcolwell-mobl.amr.corp.intel.com ([10.251.1.71])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 16:17:23 -0700
Date: Tue, 11 May 2021 16:17:23 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data
 checksum"
In-Reply-To: <YJoCFsHJjFSPgE4G@MiBook>
Message-ID: <a596fc9b-63be-5f71-d92-d3ac3b4e124b@linux.intel.com>
References: <694573465901ea0fc5318b379af75f5287a4f77f.1620360953.git.geliangtang@gmail.com> <e3d8cbf6-4de3-40da-5442-49d5265f9f5@linux.intel.com> <YJoCFsHJjFSPgE4G@MiBook>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 11 May 2021, Geliang Tang wrote:

> Hi Mat,
>
> On Mon, May 10, 2021 at 05:45:48PM -0700, Mat Martineau wrote:
>> On Fri, 7 May 2021, Geliang Tang wrote:
>>
>>> Move the csum_replace2 trunk into the later patch "mptcp: receive
>>> checksum for MP_CAPABLE with data".
>>>
>>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>>> ---
>>> net/mptcp/options.c | 3 ---
>>> 1 file changed, 3 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index beac01f58cba..99fc21406168 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -519,9 +519,6 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
>>> 		 */
>>> 		ext->data_fin = 1;
>>> 		ext->data_len++;
>>> -
>>> -		/* the pseudo header has changed, update the csum accordingly */
>>> -		csum_replace2(&ext->csum, htons(ext->data_len - 1), htons(ext->data_len));
>>
>> The commit message above says this is is moved to another patch, but the
>> posted squash-to patch for "mptcp: receive checksum for MP_CAPABLE with
>> data" doesn't add this functionality back. Is a hunk or another squash-to
>> patch missing?
>
> Sorry, I didn't describe it clearly.
>
> No squash-to patch is missing here, this truck will be moved to another
> patch automatically when resolving the conflict.
>
> Apply this squash-to patch (Squash to "mptcp: generate the data checksum")
> and rebase, we will get a conflict with "mptcp: receive checksum for
> MP_CAPABLE with data":
>
> $ git rebase --continue
> Auto-merging net/mptcp/protocol.h
> Auto-merging net/mptcp/options.c
> CONFLICT (content): Merge conflict in net/mptcp/options.c
> error: could not apply d56805c0f705... mptcp: receive checksum for MP_CAPABLE with data
>
> Resolve this conflict like this:
>
> '''
> <<<<<<< HEAD
> =======
>
>                /* the pseudo header has changed, update the csum accordingly */
>                if (ext->csum_reqd)
>                        csum_replace2(&ext->csum, htons(ext->data_len - 1),
>                                      htons(ext->data_len));
>>>>>>>> d56805c0f705... mptcp: receive checksum for MP_CAPABLE with data
>        }
> }
> '''
>
> ->
>
> '''
>
>                /* the pseudo header has changed, update the csum accordingly */
>                if (ext->csum_reqd)
>                        csum_replace2(&ext->csum, htons(ext->data_len - 1),
>                                      htons(ext->data_len));
>        }
> }
> '''
>
> Then the csum_replace2 trunk have been moved to the patch "mptcp: receive
> checksum for MP_CAPABLE with data" automatically.
>

Ok, thanks for the information. In the future if there's a 
conflict-creating squash patch like this it does help to have specific 
conflict resolution notes.

It looks like this chunk of code is not needed at all, though - 
mptcp_make_csum() hasn't been called yet so the pseudoheader has not been 
included in the checksum.

--
Mat Martineau
Intel
