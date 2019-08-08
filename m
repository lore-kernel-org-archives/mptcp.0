Content-Type: multipart/mixed; boundary="===============6645710936206441466=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 00/10] Implement outgoing MP_JOIN
Date: Thu, 08 Aug 2019 16:51:14 +0200
Message-ID: <3ea8f7461dc53afc87bd16a5063d66bdd69d21b8.camel@redhat.com>
In-Reply-To: 20190807224434.2829-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1609

--===============6645710936206441466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
On Wed, 2019-08-07 at 15:44 -0700, Peter Krystad wrote:
> This is several accumulated fixes that are required for MP_JOIN
> (secondary subflows) plus the outgoing code.
> =

> Both outgoing and incoming MP_JOIN now inter-operate
> with the multipath.org implementation although there is
> still a deadlock when incoming is fully established.
> Since the incoming direction did not work at all before
> this is an improvement. I have not yet tested running our
> implmentation against itself.
> =

> The final patch in the set is an "interim path manager", this
> is throw-away code that I include for testing purposes. For an
> incoming connection it is necessary for the server to advertise
> a secondary address and for my testing I have been hard-coding the IP
> address of my secondary interface when I build the kernel.
> Obviously not the final solution but we need to discuss what
> approach to use for the self tests. I also think we may not want
> to publish this patch on our net-next branch.
> =

> v2:
>   - move mptcp_options_received formatting to options.c
>   - resolve conflicts with Davide's crypto commit
>   - make helper for setting request fields
>   - fix locking in token_lookup()
>   - move token_lookup() to "Implement path manager interface commands:
>     (where it belongs)
>   - split interim path manager out of final commit, will submit seperately
>   - remove use of local_id in pm_create_subflow
>   - restrict announcing addresses to server side only
>   - add one more commit with get_local_id fix for incoming MP_JOIN
> =

> v3:
>   - Revise nested if logic in options.c
>   - set subflow->request_cksum correctly (do not support)
>   - lock mptcp_sock in subflow_connect() and take ref
>   - return EINPROGRESS from subflow_connect() in normal case
>   - cleanup socket when bind()/connect() fails in subflow_connect()
>   - take reference to mptcp_sock in token_join_request() and
>     token_join_valid()
>   - rename token_lookup() to token_lookup_get()
>   - track remote token seperately in subflow (previously
>     local token field was being overwritten, preventing cleanup)
>   - take long-lived reference to mptcp_sock in token_new_subflow

I went through the whole series and it looks like all my comments has
been addressed, thank you Peter!

LGMT!

Paolo


--===============6645710936206441466==--
